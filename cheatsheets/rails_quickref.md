# Rails Quick Reference ⚡

> Generators, routes, controllers, views. Scannable in 60 seconds.

---

## New Rails App

```bash
rails new myapp                        # SQLite (default)
rails new myapp --database=postgresql  # PostgreSQL
rails new myapp --api                  # API-only mode
rails new myapp -T                     # skip Test::Unit (use RSpec)
cd myapp && bundle install
rails server                           # start server on :3000
```

---

## Generators

```bash
# Model + migration
rails generate model Post title:string body:text published:boolean

# Controller + views
rails generate controller Posts index show new edit

# Full scaffold (model + controller + views + routes)
rails generate scaffold Post title:string body:text

# Migration only
rails generate migration AddPublishedAtToPosts published_at:datetime

# Run migrations
rails db:migrate
rails db:rollback          # undo last migration
rails db:migrate:status    # see which ran

# Routes
rails routes
rails routes -g posts      # filter by name
```

---

## Routes

```ruby
# config/routes.rb

root "home#index"

resources :posts                    # all 7 RESTful routes
resources :posts, only: [:index, :show]
resources :posts, except: [:destroy]

# Nested
resources :posts do
  resources :comments, shallow: true
end

# Custom actions
resources :posts do
  member   { post :publish }        # /posts/:id/publish
  collection { get :search }        # /posts/search
end

# Custom
get  "/about",   to: "pages#about", as: :about
post "/login",   to: "sessions#create", as: :login
delete "/logout", to: "sessions#destroy", as: :logout

# Namespace
namespace :admin do
  resources :posts
end
```

---

## Controller

```ruby
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.published.recent
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Deleted!"
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

---

## View Helpers

```erb
<%# Output (escaped) %>
<%= @post.title %>

<%# No output (logic) %>
<% if user_signed_in? %>

<%# Links %>
<%= link_to "Posts", posts_path %>
<%= link_to "Show", post_path(@post) %>
<%= link_to "Edit", edit_post_path(@post) %>
<%= link_to "Delete", @post, data: { turbo_method: :delete, turbo_confirm: "Sure?" } %>

<%# Partials %>
<%= render @posts %>                  <%# renders _post.html.erb for each %>
<%= render "shared/header" %>
<%= render "form", post: @post %>
<%= render partial: "post", locals: { post: @post } %>

<%# Forms %>
<%= form_with model: @post do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <%= f.text_area :body %>
  <%= f.check_box :published %>
  <%= f.submit %>
<% end %>

<%# Content for layout %>
<% content_for :title, "My Page Title" %>
<%= yield :title %>

<%# Image / asset tags %>
<%= image_tag "logo.png" %>
<%= stylesheet_link_tag "application" %>
<%= javascript_include_tag "application" %>
```

---

## Params and Strong Parameters

```ruby
# All params
params                         # ActionController::Parameters
params[:id]                    # URL param
params[:post][:title]          # nested
params.require(:post)          # raises if :post missing
params.permit(:title, :body)   # whitelist keys

# Strong params (standard pattern)
def post_params
  params.require(:post).permit(:title, :body, :tag_ids => [])
end

# Nested
params.require(:post).permit(:title, comments_attributes: [:body, :id, :_destroy])
```

---

## Redirect vs Render

```ruby
# render — stays on same action, shows a view
render :new                          # render new.html.erb
render :new, status: :unprocessable_entity  # with status code
render json: { error: "Bad" }, status: 422
render plain: "OK"

# redirect_to — tells browser to make a new request
redirect_to posts_path
redirect_to @post                    # shorthand for post_path(@post)
redirect_to @post, notice: "Done!"   # with flash message
redirect_back fallback_location: root_path   # go back
```

---

## Flash Messages

```ruby
# Set in controller
redirect_to @post, notice: "Post created!"    # flash[:notice]
redirect_to @post, alert: "Something failed!" # flash[:alert]
flash[:info] = "For your information"

# For current request only (before render)
flash.now[:notice] = "This is a notice"

# In view (application layout)
```

```erb
<% if flash[:notice] %>
  <div class="notice"><%= flash[:notice] %></div>
<% end %>
<% if flash[:alert] %>
  <div class="alert"><%= flash[:alert] %></div>
<% end %>
```
