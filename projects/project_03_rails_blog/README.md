# Project 03: Rails Blog

## Goal
Create a full Rails blog app with CRUD for posts/comments, user authentication with `has_secure_password`, and RSpec coverage.

## MVC Diagram (ASCII)

```text
Browser
  |
  v
Routes -> Controllers -> Models -> Database
  |          |             |
  |          v             v
  +-------> Views <----- ActiveRecord
```

## ERD Diagram (ASCII)

```text
users
- id
- email
- password_digest

posts
- id
- title
- body
- user_id

comments
- id
- body
- post_id
- user_id

users 1---* posts
users 1---* comments
posts 1---* comments
```

## Architecture Diagram (ASCII)

```text
[Client] -> [Rails Router] -> [PostsController/CommentsController/SessionsController]
                      |-> [Post/Comment/User models] -> [SQLite/PostgreSQL]
```

## Design Decisions (Plain Language)
- Use standard Rails MVC for predictable structure.
- Keep auth simple with `has_secure_password` and session cookies.
- Nest comments under posts for clean URL semantics.
- Use request/model specs so behavior is verified end-to-end.

## How this maps to real-world use
This matches internal tools and content platforms where authenticated users create posts, discuss in comments, and need maintainable CRUD endpoints.

## Step-by-step run instructions (Linux Mint)
1. Go to this project directory:
   ```bash
   cd projects/project_03_rails_blog
   ```
2. Generate the Rails app scaffold:
   ```bash
   bash src/build_blog_app.sh
   ```
3. Enter generated app and prepare DB:
   ```bash
   cd src/rails_blog_app
   bundle install
   bin/rails db:create db:migrate
   ```
4. Run server:
   ```bash
   bin/rails server
   ```
5. Run RSpec tests:
   ```bash
   bundle exec rspec
   ```
