# Routing Reference 🗺️

> Complete guide to Rails routing.

---

## Mental Model — Routes as a Switchboard

```
┌──────────────────────────────────────────────────────────┐
│                ROUTES AS SWITCHBOARD                     │
│                                                          │
│  Incoming request           Controller#action            │
│  ─────────────────          ──────────────────           │
│  GET /posts          ──►   posts#index                   │
│  GET /posts/new      ──►   posts#new                     │
│  POST /posts         ──►   posts#create                  │
│  GET /posts/1        ──►   posts#show                    │
│  GET /posts/1/edit   ──►   posts#edit                    │
│  PATCH /posts/1      ──►   posts#update                  │
│  DELETE /posts/1     ──►   posts#destroy                 │
└──────────────────────────────────────────────────────────┘
```

---

## RESTful Routes Table (All 7 Actions)

```ruby
resources :posts
```

| HTTP Verb | Path | Controller#Action | Purpose | Path Helper |
|-----------|------|-------------------|---------|-------------|
| GET | /posts | posts#index | List all posts | `posts_path` |
| GET | /posts/new | posts#new | Form for new post | `new_post_path` |
| POST | /posts | posts#create | Create new post | `posts_path` |
| GET | /posts/:id | posts#show | Show one post | `post_path(@post)` |
| GET | /posts/:id/edit | posts#edit | Form to edit post | `edit_post_path(@post)` |
| PATCH/PUT | /posts/:id | posts#update | Update post | `post_path(@post)` |
| DELETE | /posts/:id | posts#destroy | Delete post | `post_path(@post)` |

**Limit the actions generated:**

```ruby
resources :photos, only: [:index, :show]
resources :photos, except: [:destroy]
```

---

## Nested Routes

```ruby
resources :posts do
  resources :comments    # /posts/:post_id/comments/:id
end
```

| HTTP Verb | Path | Controller#Action |
|-----------|------|-------------------|
| GET | /posts/:post_id/comments | comments#index |
| POST | /posts/:post_id/comments | comments#create |
| GET | /posts/:post_id/comments/:id | comments#show |
| DELETE | /posts/:post_id/comments/:id | comments#destroy |

```ruby
# In CommentsController
def index
  @post    = Post.find(params[:post_id])
  @comments = @post.comments
end
```

**Avoid more than one level of nesting:**

```ruby
# Instead of deeply nested:
resources :publishers do
  resources :magazines do
    resources :photos  # ← too deep
  end
end

# Use shallow:
resources :posts do
  resources :comments, shallow: true
end
# GET /posts/:post_id/comments   (index, new, create)
# GET /comments/:id              (show, edit, update, destroy)
```

---

## Namespaces

```ruby
namespace :admin do
  resources :posts    # /admin/posts → Admin::PostsController
end

# Scope without URL prefix
scope module: :admin do
  resources :posts    # /posts → Admin::PostsController
end

# Scope without module
scope "/admin" do
  resources :posts    # /admin/posts → PostsController
end
```

---

## Path Helpers

```ruby
# Given: resources :posts

posts_path           # => "/posts"
post_path(@post)     # => "/posts/1"
new_post_path        # => "/posts/new"
edit_post_path(@post)# => "/posts/1/edit"

# URL helpers (include host)
posts_url            # => "http://localhost:3000/posts"

# In views
link_to "Posts", posts_path
link_to "Show", post_path(@post)
link_to "Edit", edit_post_path(@post)
link_to "Delete", post_path(@post), method: :delete

# In controllers
redirect_to posts_path
redirect_to post_path(@post)
redirect_to @post   # shorthand for post_path(@post)
```

---

## Custom Routes

```ruby
Rails.application.routes.draw do
  # Root
  root "home#index"

  # Static pages
  get "/about",   to: "pages#about"
  get "/contact", to: "pages#contact"

  # Custom member action (operates on one resource)
  resources :posts do
    member do
      post :publish       # POST /posts/:id/publish → posts#publish
      post :unpublish     # POST /posts/:id/unpublish → posts#unpublish
      get  :preview       # GET  /posts/:id/preview → posts#preview
    end

    collection do
      get  :search        # GET /posts/search → posts#search
      get  :drafts        # GET /posts/drafts → posts#drafts
    end
  end

  # Named route
  get "/login",  to: "sessions#new",     as: :login
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  # Redirect
  get "/old-path", to: redirect("/new-path")

  # Constraints
  get "/api/:version/users", to: "api/users#index",
      constraints: { version: /v\d+/ }
end
```

**Check your routes:**

```bash
rails routes            # all routes
rails routes -g posts   # filter by name
rails routes -c posts   # filter by controller
```

**Checklist:**
- [ ] I know all 7 RESTful actions and their HTTP verbs
- [ ] I can generate nested routes and access parent params
- [ ] I can use namespaces to organize admin routes
- [ ] I can use path helpers in views and controllers
- [ ] I can add custom member and collection actions

**Common mistakes:**
- Nesting routes more than one level deep (makes path helpers unwieldy)
- Using `get` for destructive actions (use `delete`, `patch`, `post`)
- Forgetting to check `rails routes` when debugging routing errors
