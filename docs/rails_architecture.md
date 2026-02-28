# Rails Architecture Reference 🏛️

> Where everything goes and why.

---

## Full MVC Flow Diagram

```
Request → Router → Controller → Model → View → Response

┌──────────────────────────────────────────────────────────────────────┐
│                      FULL RAILS REQUEST FLOW                         │
│                                                                      │
│  1. Browser: GET /posts/1                                            │
│                  │                                                   │
│  2. Router (config/routes.rb)                                        │
│     resources :posts → posts#show                                    │
│                  │                                                   │
│  3. Before Actions (app/controllers/posts_controller.rb)             │
│     before_action :authenticate_user!                                │
│     before_action :find_post                                         │
│                  │                                                   │
│  4. Controller Action: posts#show                                    │
│     @post = Post.find(params[:id])                                   │
│                  │                                                   │
│  5. Model (app/models/post.rb)                                       │
│     Post.find(id) → SQL: SELECT * FROM posts WHERE id = 1           │
│     Returns Post object with associations, validations               │
│                  │                                                   │
│  6. View (app/views/posts/show.html.erb)                             │
│     Renders HTML using @post instance variable                       │
│                  │                                                   │
│  7. Response: 200 OK + HTML body sent to browser                     │
└──────────────────────────────────────────────────────────────────────┘
```

---

## Complete Folder Structure

```
my_rails_app/
├── app/                        ← Your application code lives here
│   ├── assets/                 ← CSS, JS, images
│   │   ├── images/
│   │   ├── stylesheets/
│   │   └── config/
│   ├── channels/               ← ActionCable (WebSockets)
│   ├── controllers/            ← Request handlers
│   │   ├── application_controller.rb  ← Base controller
│   │   ├── concerns/           ← Shared controller modules
│   │   └── posts_controller.rb
│   ├── helpers/                ← View helper methods
│   ├── javascript/             ← Hotwire/Stimulus JS
│   ├── jobs/                   ← Background jobs
│   ├── mailers/                ← Email templates
│   ├── models/                 ← ActiveRecord models + business logic
│   │   ├── application_record.rb  ← Base model
│   │   ├── concerns/           ← Shared model modules
│   │   └── post.rb
│   ├── services/               ← Service objects (add this yourself)
│   └── views/                  ← ERB templates
│       ├── layouts/            ← Application layout
│       │   └── application.html.erb
│       └── posts/              ← Views for PostsController
│           ├── index.html.erb
│           ├── show.html.erb
│           ├── new.html.erb
│           └── edit.html.erb
│
├── config/                     ← Configuration
│   ├── routes.rb               ← URL routing rules
│   ├── database.yml            ← Database configuration
│   ├── application.rb          ← App-level config
│   └── environments/           ← Per-environment config
│       ├── development.rb
│       ├── production.rb
│       └── test.rb
│
├── db/                         ← Database
│   ├── migrate/                ← Migration files (schema changes)
│   ├── schema.rb               ← Current database schema
│   └── seeds.rb                ← Seed data
│
├── spec/ or test/              ← Tests
│   ├── models/
│   ├── controllers/
│   ├── requests/
│   └── system/
│
├── Gemfile                     ← Ruby dependencies
├── Gemfile.lock
└── README.md
```

---

## Where Business Logic Lives

| Logic Type | Where it Goes | Example |
|-----------|--------------|---------|
| Data rules | Model | `validates :title, presence: true` |
| Data queries | Model (scope) | `scope :published, -> { where(published: true) }` |
| Complex operations | Service object | `PublishPostService.call(post)` |
| Reusable model behavior | Model concern | `include Publishable` |
| View formatting | Helper | `format_date(post.published_at)` |
| Request handling | Controller | `@post = Post.find(params[:id])` |
| Shared controller behavior | Controller concern | `include Authenticatable` |
| Background work | Job | `SendWelcomeEmailJob.perform_later(user)` |

---

## Where NOT to Put Things

| ❌ Don't | ✅ Instead |
|---------|----------|
| Business logic in controller | Move to model or service object |
| Database queries in view | Move to controller or model scope |
| Formatting logic in model | Move to helper or presenter |
| Many responsibilities in one class | Extract to smaller, focused classes |
| Raw SQL in controller | Use ActiveRecord scopes/methods |

---

## Code Examples for Each Layer

### Router (config/routes.rb)

```ruby
Rails.application.routes.draw do
  root "home#index"
  
  resources :posts do                    # 7 RESTful routes
    resources :comments, only: [:create, :destroy]   # nested
    member do
      post :publish                      # POST /posts/:id/publish
    end
    collection do
      get :search                        # GET /posts/search
    end
  end
  
  namespace :admin do                    # /admin/posts
    resources :posts
  end
end
```

### Controller (app/controllers/posts_controller.rb)

```ruby
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.published.recent.page(params[:page])
  end

  def show
    # @post set by before_action
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :published)
  end
end
```

### Model (app/models/post.rb)

```ruby
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, presence: true
  
  scope :published, -> { where(published: true) }
  scope :recent,    -> { order(created_at: :desc) }

  before_save :set_slug

  def publish!
    update!(published: true, published_at: Time.current)
  end

  def word_count
    body.split.length
  end

  private

  def set_slug
    self.slug = title.parameterize
  end
end
```

### View (app/views/posts/show.html.erb)

```erb
<article>
  <h1><%= @post.title %></h1>
  <p class="meta">
    By <%= @post.user.name %> on <%= @post.published_at.strftime("%B %d, %Y") %>
  </p>
  <div class="body">
    <%= simple_format(@post.body) %>
  </div>
</article>

<% if current_user == @post.user %>
  <%= link_to "Edit", edit_post_path(@post), class: "btn" %>
  <%= button_to "Delete", @post, method: :delete, data: { confirm: "Are you sure?" } %>
<% end %>
```

### Service Object (app/services/publish_post_service.rb)

```ruby
class PublishPostService
  Result = Struct.new(:success?, :post, :errors)

  def self.call(post, user)
    new(post, user).call
  end

  def initialize(post, user)
    @post = post
    @user = user
  end

  def call
    return Result.new(false, @post, ["Unauthorized"]) unless authorized?
    return Result.new(false, @post, ["Already published"]) if @post.published?

    if @post.publish!
      NotifySubscribersJob.perform_later(@post)
      Result.new(true, @post, [])
    else
      Result.new(false, @post, @post.errors.full_messages)
    end
  end

  private

  def authorized?
    @user == @post.user || @user.admin?
  end
end
```

**Checklist:**
- [ ] I know what each folder in a Rails app does
- [ ] I know to put business logic in models, not controllers
- [ ] I know how to use service objects for complex operations
- [ ] I can trace a request through the full MVC flow
- [ ] I know the difference between `redirect_to` and `render`
