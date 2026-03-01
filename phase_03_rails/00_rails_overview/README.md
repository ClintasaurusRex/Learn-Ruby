# Lesson 00 — Rails Overview

---

## 1) Concept Overview

Rails is a web framework built on Ruby that follows MVC (Model-View-Controller).
A browser request enters your Rails app through the router, is handled by a controller action,
optionally uses models for data access/business rules, and finally renders a view.

---

## 2) Mental Model Diagram

### Full MVC flow (required)

```
Browser
  |
  | GET /posts/1
  v
config/routes.rb
  |
  v
PostsController#show
  |
  | fetches data
  v
Post (Active Record model)
  |
  | SQL
  v
Database
  |
  | returns rows
  v
Post object(s)
  |
  v
app/views/posts/show.html.erb
  |
  v
HTML response -> Browser
```

### Request lifecycle diagram (required)

```
[Request arrives]
      |
      v
[Router matches path + verb]
      |
      v
[Controller action runs]
      |
      +--> [before_action callbacks]
      |
      +--> [model/service calls]
      |
      v
[Render or redirect]
      |
      v
[Middleware finalizes response]
      |
      v
[Response sent]
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# Starter rails commands to run in terminal:
# rails new blog --database=postgresql
# cd blog
# bin/rails server
# open http://localhost:3000
```

---

## 4) You Type This

1. Explain MVC in your own words.
2. Name where routes, controllers, and views live.
3. Run `rails -v` to verify Rails is installed.
4. Draw your own request path for `/articles`.

---

## 5) Expand the Example

Use this flow when reading any Rails feature:

- Request verb + path
- Matched route
- Controller action
- Model query/write
- Rendered template

---

## 6) Real-World Application

In production apps, this flow powers dashboards, checkout pages, APIs, and admin tools.
Knowing the lifecycle helps you debug quickly and place code in the right layer.

---

## 7) Checklist

- [ ] I can describe MVC in one sentence.
- [ ] I can name the path from request to response.
- [ ] I can explain what the router does.
- [ ] I can explain what a controller action does.
- [ ] I can explain what a model does.
- [ ] I can explain what a view does.

---

## 8) Common Mistakes

| Mistake | Fix |
|---|---|
| Putting SQL in views | Keep DB logic in models |
| Skipping routes and calling views directly | Route every web endpoint |
| Huge controllers | Move reusable business logic out |

---

## 9) Debug Flow

```
Wrong page or 404?
  -> Check routes with: bin/rails routes
Wrong data?
  -> Inspect controller action + model query
Template error?
  -> Verify render path and ivars (@post, @user)
```

---

## 10) Stretch Goal

Create a tiny app with one `PagesController#home` action and trace the full request lifecycle from browser to rendered HTML.
