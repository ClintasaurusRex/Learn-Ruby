# ActiveRecord Quick Reference ⚡

> CRUD, associations, scopes, validations. Scannable in 60 seconds.

---

## CRUD

```ruby
# CREATE
Post.create(title: "Hi", body: "World")   # save immediately
Post.create!(title: "Hi")                 # raises on failure
post = Post.new(title: "Hi")              # not saved
post.save                                 # save (returns true/false)
post.save!                                # save (raises on failure)

# READ
Post.all
Post.first / Post.last
Post.find(1)                              # raises if not found
Post.find([1, 2, 3])                      # find multiple
Post.find_by(slug: "hello")              # nil if not found
Post.find_by!(slug: "hello")             # raises if not found
Post.where(published: true)
Post.where("age > ?", 18)
Post.where(age: 18..30)                  # range
Post.where.not(published: nil)
Post.order(created_at: :desc)
Post.order(:title)
Post.limit(10).offset(20)
Post.count / Post.sum(:views) / Post.average(:rating)
Post.pluck(:title)                        # ["Title1", "Title2"] — no objects
Post.select(:id, :title)                 # partial objects
Post.distinct

# UPDATE
post.update(title: "New")               # true/false
post.update!(title: "New")              # raises
post.title = "New"; post.save
Post.update_all(published: true)        # bulk, no callbacks

# DELETE
post.destroy                             # callbacks run
post.delete                              # no callbacks, direct SQL
Post.where(published: false).destroy_all
Post.destroy_all                         # dangerous!
```

---

## Associations

```ruby
# belongs_to
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true       # nullable foreign key
end

# has_many
class Post < ApplicationRecord
  has_many :comments
  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, source: :user
end

# has_one
class User < ApplicationRecord
  has_one :profile
  has_one :profile, dependent: :destroy
end

# has_and_belongs_to_many (needs join table)
class Post < ApplicationRecord
  has_and_belongs_to_many :tags
end

# has_many :through (join model)
class User < ApplicationRecord
  has_many :enrollments
  has_many :courses, through: :enrollments
end
```

---

## Association Methods

```ruby
user.posts                    # ActiveRecord::Relation
user.posts.create(title: "x") # create associated record
user.posts.build(title: "x")  # new but not saved
user.posts.count
user.posts << post            # add to collection
user.posts.delete(post)       # remove from collection

post.user                     # returns User or nil
post.user_id                  # foreign key integer
post.build_user(name: "x")    # build user (not saved)
post.create_user!(name: "x")  # create and save user
```

---

## Validations

```ruby
validates :title, presence: true
validates :title, length: { minimum: 3, maximum: 200 }
validates :email, uniqueness: true
validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
validates :age,   numericality: { greater_than: 0 }
validates :status, inclusion: { in: %w[draft published] }
validates :bio,   length: { in: 10..500 }, allow_blank: true

# Conditional
validates :admin_code, presence: true, if: :admin?
validates :terms,      acceptance: true, on: :create

# Custom
validate :end_date_after_start_date

def end_date_after_start_date
  return unless end_date && start_date
  errors.add(:end_date, "must be after start date") if end_date < start_date
end

# Using validations
post.valid?                         # runs validations, true/false
post.invalid?
post.errors.full_messages           # ["Title can't be blank"]
post.errors[:title]                 # ["can't be blank"]
post.errors.add(:base, "Oops")      # add error to base
```

---

## Scopes

```ruby
class Post < ApplicationRecord
  scope :published,    -> { where(published: true) }
  scope :drafts,       -> { where(published: false) }
  scope :recent,       -> { order(created_at: :desc) }
  scope :by_author,    ->(user) { where(user: user) }
  scope :popular,      -> { order(views_count: :desc) }
  scope :with_comments,-> { joins(:comments).distinct }
end

# Chaining
Post.published.recent.limit(10)
Post.by_author(current_user).published
```

---

## Eager Loading (Solve N+1)

```ruby
# Bad — N+1 queries
Post.all.each { |p| puts p.user.name }

# Good — eager load
Post.includes(:user).each { |p| puts p.user.name }
Post.includes(:user, :tags, comments: :user)

# Force join (for filtering)
Post.joins(:user).where(users: { admin: true })

# Preload (always 2 queries)
Post.preload(:user)

# Eager load (always JOIN)
Post.eager_load(:user)
```

---

## Migrations

```bash
rails generate migration CreatePosts title:string body:text
rails generate migration AddPublishedToPosts published:boolean
rails generate migration AddIndexToPostsTitle
rails db:migrate
rails db:rollback
rails db:migrate VERSION=20240101000000
```

```ruby
# In migration file
def change
  create_table :posts do |t|
    t.string  :title, null: false
    t.text    :body
    t.boolean :published, default: false
    t.references :user, null: false, foreign_key: true
    t.timestamps  # created_at, updated_at
  end

  add_index :posts, :slug, unique: true
  add_column :posts, :views_count, :integer, default: 0
  rename_column :posts, :text, :body
  remove_column :posts, :old_field
end
```
