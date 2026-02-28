# Common Ruby Patterns ⚡

> Guard clauses, memoization, service objects, and more. Scannable in 60 seconds.

---

## Guard Clauses

Fail fast. Flatten nesting. Return early.

```ruby
# Bad — nested, hard to read
def process(user)
  if user
    if user.active?
      if user.admin?
        do_admin_stuff(user)
      else
        do_user_stuff(user)
      end
    end
  end
end

# Good — guard clauses
def process(user)
  return unless user
  return unless user.active?

  if user.admin?
    do_admin_stuff(user)
  else
    do_user_stuff(user)
  end
end
```

---

## Safe Navigation Operator (&.)

Call methods on objects that might be nil.

```ruby
# Dangerous
user.profile.avatar.url    # NoMethodError if any is nil

# Safe
user&.profile&.avatar&.url  # => nil if any is nil

# Common uses
current_user&.admin?
params[:post]&.fetch(:title)
user&.name&.upcase
```

---

## Memoization

Cache the result of an expensive operation.

```ruby
class ReportGenerator
  def data
    @data ||= fetch_from_database      # only runs once
  end

  def totals
    @totals ||= calculate_totals(data) # only runs once
  end

  private

  def fetch_from_database
    # expensive DB call
    Record.complex_query.to_a
  end
end

# Memoize with nil/false values (||= won't work)
def settings
  return @settings if defined?(@settings)
  @settings = load_settings    # works even if settings is nil or false
end
```

---

## Method Chaining

Return `self` to enable chaining.

```ruby
class QueryBuilder
  def initialize
    @conditions = []
    @limit_val  = nil
    @order_val  = nil
  end

  def where(condition)
    @conditions << condition
    self    # ← return self to enable chaining
  end

  def limit(n)
    @limit_val = n
    self
  end

  def order(field)
    @order_val = field
    self
  end

  def to_sql
    sql = "SELECT * FROM records"
    sql += " WHERE #{@conditions.join(' AND ')}" if @conditions.any?
    sql += " ORDER BY #{@order_val}" if @order_val
    sql += " LIMIT #{@limit_val}" if @limit_val
    sql
  end
end

QueryBuilder.new
  .where("age > 18")
  .where("active = true")
  .order("name")
  .limit(10)
  .to_sql
```

---

## Null Object Pattern

Avoid nil checks by returning a safe "null" object.

```ruby
class NullUser
  def name    = "Guest"
  def admin?  = false
  def signed_in? = false
  def posts   = []
end

class ApplicationController
  def current_user
    @current_user ||= find_user_from_session || NullUser.new
  end
end

# Now you never need nil checks:
current_user.name       # "Guest" for null user, real name for real user
current_user.admin?     # false for null user
current_user.posts.each { ... }  # empty array, no error
```

---

## Service Object

Encapsulate a complex business operation.

```ruby
# app/services/register_user_service.rb
class RegisterUserService
  Result = Struct.new(:success?, :user, :errors)

  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    user = User.new(@params)

    unless user.valid?
      return Result.new(false, user, user.errors.full_messages)
    end

    user.save!
    send_welcome_email(user)
    Result.new(true, user, [])
  rescue StandardError => e
    Result.new(false, nil, [e.message])
  end

  private

  def send_welcome_email(user)
    UserMailer.welcome(user).deliver_later
  end
end

# Usage in controller
def create
  result = RegisterUserService.call(user_params)
  if result.success?
    redirect_to dashboard_path, notice: "Welcome!"
  else
    @errors = result.errors
    render :new
  end
end
```

---

## Decorator Pattern

Add behavior to objects without changing their class.

```ruby
class Post
  attr_reader :title, :body, :published_at

  def initialize(title, body, published_at)
    @title        = title
    @body         = body
    @published_at = published_at
  end
end

class PostDecorator
  def initialize(post)
    @post = post
  end

  def formatted_date
    @post.published_at&.strftime("%B %d, %Y") || "Unpublished"
  end

  def truncated_body(length = 100)
    @post.body.length > length ? "#{@post.body[0, length]}..." : @post.body
  end

  def method_missing(method, *args, &block)
    @post.send(method, *args, &block)  # delegate everything else
  end

  def respond_to_missing?(method, include_private = false)
    @post.respond_to?(method, include_private) || super
  end
end

decorated = PostDecorator.new(post)
decorated.title            # delegates to post
decorated.formatted_date   # "February 28, 2026"
decorated.truncated_body   # "First 100 chars..."
```

---

## Proc Composition

Combine procs/lambdas with `>>` and `<<`.

```ruby
double  = ->(n) { n * 2 }
add_one = ->(n) { n + 1 }
square  = ->(n) { n ** 2 }

# >> composes left to right
transform = double >> add_one >> square
transform.call(3)   # ((3 * 2) + 1)^2 = 49

# << composes right to left
transform = square << add_one << double
transform.call(3)   # same result
```

---

## Struct

Quick way to create value objects.

```ruby
Point = Struct.new(:x, :y)
p = Point.new(1, 2)
p.x    # 1
p.y    # 2

# With methods
Point = Struct.new(:x, :y) do
  def distance_from_origin
    Math.sqrt(x**2 + y**2)
  end
end

# Useful for service object results
Result = Struct.new(:success?, :value, :errors, keyword_init: true)
result = Result.new(success?: true, value: user, errors: [])
result.success?   # true
```

---

## Enumerable Patterns

```ruby
# Partition into two arrays
evens, odds = (1..10).partition(&:even?)

# Group by attribute
posts_by_status = posts.group_by(&:status)
# { "draft" => [...], "published" => [...] }

# Chain operations
users
  .select(&:active?)
  .reject(&:admin?)
  .sort_by(&:name)
  .first(10)

# tally — count occurrences
["a", "b", "a", "c", "b", "a"].tally
# => {"a"=>3, "b"=>2, "c"=>1}

# flat_map — map + flatten
[[1,2], [3,4]].flat_map { |arr| arr.map { |n| n * 2 } }
# => [2, 4, 6, 8]

# each_with_object — build a result as you iterate
(1..5).each_with_object([]) { |n, arr| arr << n * 2 if n.odd? }
# => [2, 6, 10]
```
