# Lesson 03 — Routing

---

## 1) Concept Overview

Routing maps an HTTP verb + URL path to a controller action.
In Rails, routes are defined in `config/routes.rb`.

---

## 2) Mental Model Diagram

### Routes table (required)

| Verb | Path | Controller#Action | Named Helper |
|---|---|---|---|
| GET | /posts | posts#index | posts_path |
| GET | /posts/:id | posts#show | post_path(id) |
| POST | /posts | posts#create | posts_path |
| PATCH | /posts/:id | posts#update | post_path(id) |
| DELETE | /posts/:id | posts#destroy | post_path(id) |

### Request -> router -> controller flow diagram (required)

```
HTTP Request
   |
   | verb + path
   v
Rails Router (routes.rb)
   |
   | finds first match
   v
Controller#action
   |
   v
Render/Redirect Response
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# config/routes.rb starter idea:
# Rails.application.routes.draw do
#   resources :posts
# end
```

---

## 4) You Type This

1. Add a root route.
2. Add `resources :posts`.
3. Add one custom route for health check.
4. Run `bin/rails routes`.

---

## 5) Expand the Example

Try member vs collection routes and note helper name differences.

---

## 6) Real-World Application

APIs and web apps both rely on routing clarity.
Good route design improves maintainability and discoverability.

---

## 7) Checklist

- [ ] I can read a routes table.
- [ ] I can map a request to an action.
- [ ] I can generate RESTful routes.
- [ ] I can inspect route helpers.

---

## 8) Common Mistakes

| Mistake | Fix |
|---|---|
| Duplicate or conflicting routes | Keep route file ordered and intentional |
| Using wrong verb | Match REST conventions |
| Hardcoding URLs in views | Use path helpers |

---

## 9) Debug Flow

```
Route not found?
  -> run bin/rails routes | grep <keyword>
Wrong controller hit?
  -> check route order (first match wins)
Helper missing?
  -> inspect named route helper column
```

---

## 10) Stretch Goal

Design routes for a blog with posts, comments, and admin namespace.
