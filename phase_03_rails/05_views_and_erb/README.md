# Lesson 05 — Views and ERB

---

## 1) Concept Overview

Views generate HTML (or other formats) from data prepared by controllers.
ERB lets you embed Ruby inside templates.

---

## 2) Mental Model Diagram

### View rendering pipeline diagram (required)

```
Controller action
   |
   | sets instance vars (@post, @user)
   v
Template lookup (e.g., posts/show.html.erb)
   |
   | ERB evaluation
   v
Layout wraps template (application.html.erb)
   |
   v
Final HTML response
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# app/views/posts/show.html.erb
# <h1><%= @post.title %></h1>
# <p><%= @post.body %></p>
```

---

## 4) You Type This

1. Render an instance variable with `<%= %>`.
2. Add an `if` conditional block in ERB.
3. Extract repeated markup into a partial.

---

## 5) Expand the Example

Add a partial `_post.html.erb` and render it from `index.html.erb` for each post.

---

## 6) Real-World Application

Readable templates reduce frontend bugs and help product teams iterate quickly.

---

## 7) Checklist

- [ ] I can explain `<% %>` vs `<%= %>`.
- [ ] I can render data from instance variables.
- [ ] I can use partials for reuse.
- [ ] I can keep heavy logic out of templates.

---

## 8) Common Mistakes

| Mistake | Fix |
|---|---|
| Business logic in ERB | Move to model/helper/service |
| N+1 caused by view loops | Preload associations in controller/model |
| Forgetting escaping context | Use Rails helpers and safe APIs |

---

## 9) Debug Flow

```
Blank value in template?
  -> verify instance variable set in controller
Template missing error?
  -> check exact view path and file name
Unexpected HTML?
  -> inspect generated HTML source in browser
```

---

## 10) Stretch Goal

Build a list view using partials and conditional empty-state messaging.
