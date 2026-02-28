# ActiveRecord Reference 📊

> Complete guide to working with the database in Rails.

---

## Mental Model — ActiveRecord Is a Translator

```
┌──────────────────────────────────────────────────────┐
│  Ruby Object         SQL Operation                  │
│  ─────────────────   ─────────────────────────────  │
│  Model.new(attrs)    (not saved yet)                │
│  Model.create(attrs) INSERT INTO models (...)        │
│  Model.find(id)      SELECT * WHERE id = ?           │
│  Model.where(...)    SELECT * WHERE ...              │
│  model.update(attrs) UPDATE models SET ... WHERE id  │
│  model.destroy       DELETE FROM models WHERE id     │
└──────────────────────────────────────────────────────┘
```

---

## Full CRUD Examples

```ruby
# CREATE
post = Post.new(title: "Hello", body: "World")
post.save          # returns true/false

post = Post.create(title: "Hello", body: "World")  # new + save
post = Post.create!(title: "Hello")  # raises ActiveRecord::RecordInvalid on failure

# READ
Post.all                          # all posts
Post.first                        # first post
Post.last                         # last post
Post.find(1)                      # find by id (raises if not found)
Post.find_by(title: "Hello")      # find by attribute (returns nil if not found)
Post.find_by!(title: "Hello")     # raises if not found
Post.where(published: true)       # returns ActiveRecord::Relation (array-like)
Post.where("created_at > ?", 1.week.ago)
Post.order(created_at: :desc)
Post.limit(10).offset(20)
Post.count
Post.pluck(:title)                # ["Hello", "World"] — just values, no objects

# UPDATE
post = Post.find(1)
post.update(title: "New Title")   # returns true/false
post.update!(title: "New Title")  # raises on failure
post.title = "New Title"
post.save

Post.update_all(published: false) # update all rows at once

# DELETE
post.destroy                      # callbacks fire
post.delete                       # no callbacks, direct SQL
Post.destroy_all(published: false)
Post.where(published: false).destroy_all
```

---

## All Association Types

```ruby
class User < ApplicationRecord
  has_one    :profile                    # user has one profile
  has_many   :posts                      # user has many posts
  has_many   :comments, through: :posts  # user has many comments via posts
  has_and_belongs_to_many :roles         # many-to-many via join table
end

class Post < ApplicationRecord
  belongs_to :user                       # post belongs to one user
  has_many   :comments
  has_many   :commenters, through: :comments, source: :user
end

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
end

class Profile < ApplicationRecord
  belongs_to :user
end
```

**Association methods generated:**

```ruby
user = User.find(1)

# has_one
user.profile                    # Profile object or nil
user.create_profile(bio: "...")
user.build_profile(bio: "...")

# has_many
user.posts                      # ActiveRecord::Relation
user.posts.create(title: "Hi")
user.posts.build(title: "Hi")   # not saved
user.posts.count
user.posts.where(published: true)

# belongs_to
post.user                       # User object
post.user_id                    # foreign key integer
```

---

## Eager Loading vs Lazy Loading

```ruby
# LAZY LOADING — N+1 problem
posts = Post.all
posts.each { |p| puts p.user.name }  # ← fires a query for each post's user!

# EAGER LOADING — solve N+1
posts = Post.includes(:user)
posts.each { |p| puts p.user.name }  # ← one query for all users

# Multiple associations
Post.includes(:user, :comments, tags: :category)

# Force join (for filtering on association)
Post.joins(:user).where(users: { admin: true })

# preload vs eager_load
Post.preload(:user)       # always separate queries (2 queries)
Post.eager_load(:user)    # always LEFT OUTER JOIN (1 query)
Post.includes(:user)      # Rails decides which strategy to use
```

---

## Validations

```ruby
class Post < ApplicationRecord
  # Presence
  validates :title, presence: true
  validates :body,  presence: true

  # Length
  validates :title, length: { minimum: 3, maximum: 200 }
  validates :bio,   length: { in: 10..500 }

  # Uniqueness
  validates :email, uniqueness: true
  validates :email, uniqueness: { case_sensitive: false }

  # Format
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Numericality
  validates :age, numericality: { greater_than: 0, less_than: 150 }
  validates :rating, numericality: { in: 1..5 }

  # Inclusion / Exclusion
  validates :status, inclusion: { in: %w[draft published archived] }

  # Custom validation
  validate :title_cannot_contain_profanity

  private

  def title_cannot_contain_profanity
    if title&.include?("badword")
      errors.add(:title, "cannot contain inappropriate language")
    end
  end
end

# Using validations
post = Post.new
post.valid?            # => false
post.errors.full_messages  # => ["Title can't be blank", ...]
post.errors[:title]    # => ["can't be blank"]
post.save              # => false (validation failed)
post.save!             # raises ActiveRecord::RecordInvalid
```

---

## Scopes

```ruby
class Post < ApplicationRecord
  scope :published,   -> { where(published: true) }
  scope :drafts,      -> { where(published: false) }
  scope :recent,      -> { order(created_at: :desc) }
  scope :popular,     -> { order(views_count: :desc) }
  scope :by_user,     ->(user) { where(user: user) }
  scope :created_after, ->(date) { where("created_at > ?", date) }
end

# Chaining scopes
Post.published.recent.limit(10)
Post.by_user(current_user).published
Post.created_after(1.week.ago).popular
```

---

## Callbacks

```
┌──────────────────────────────────────────────────────┐
│                CALLBACK ORDER                        │
│                                                      │
│  SAVE:                                               │
│    before_validation                                 │
│    after_validation                                  │
│    before_save                                       │
│    before_create (if new) / before_update (if exists)│
│    → DATABASE WRITE ←                                │
│    after_create / after_update                       │
│    after_save                                        │
│    after_commit / after_rollback                     │
│                                                      │
│  DESTROY:                                            │
│    before_destroy                                    │
│    → DATABASE DELETE ←                               │
│    after_destroy                                     │
│    after_commit                                      │
└──────────────────────────────────────────────────────┘
```

```ruby
class User < ApplicationRecord
  before_validation :downcase_email
  before_create     :generate_token
  after_create      :send_welcome_email
  before_destroy    :archive_posts

  private

  def downcase_email
    self.email = email&.downcase
  end

  def generate_token
    self.token = SecureRandom.hex(20)
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end

  def archive_posts
    posts.update_all(archived: true)
  end
end
```

**Checklist:**
- [ ] I can perform all CRUD operations with ActiveRecord
- [ ] I know the four association types and when to use each
- [ ] I can use `includes` to solve N+1 query problems
- [ ] I can write model validations and handle errors
- [ ] I can write named scopes and chain them
- [ ] I understand callback order and when to use callbacks

**Common mistakes:**
- Using `find_by` when you want `find` (find_by returns nil instead of raising)
- Forgetting `includes` and creating N+1 queries
- Putting complex queries in the controller (use scopes in the model)
- Using callbacks for side effects that should be in service objects
