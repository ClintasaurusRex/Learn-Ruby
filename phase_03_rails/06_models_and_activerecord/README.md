# Lesson 06 — Models and Active Record

---

## 1) Concept Overview

Active Record models map Ruby objects to database tables.
You write Ruby, Active Record translates to SQL.

---

## 2) Mental Model Diagram

### Active Record translator diagram (required)

```
Ruby Code
  Post.where(published: true).order(created_at: :desc)
        |
        v
Active Record Query Builder
        |
        v
Generated SQL
  SELECT * FROM posts
  WHERE published = true
  ORDER BY created_at DESC;
        |
        v
Database rows -> Post model instances
```

### CRUD flow diagram (required)

```
Create: Post.create(...)   -> INSERT
Read:   Post.find(id)      -> SELECT
Update: post.update(...)   -> UPDATE
Delete: post.destroy       -> DELETE
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# class Post < ApplicationRecord
#   validates :title, presence: true
# end
```

---

## 4) You Type This

1. Add one validation.
2. Add one scope.
3. Create and query sample records in console.

---

## 5) Expand the Example

Create a model with associations and validate that invalid records fail to save.

---

## 6) Real-World Application

Most Rails apps spend significant time in model/query design.
Good Active Record usage improves correctness and performance.

---

## 7) Checklist

- [ ] I can explain AR-to-SQL translation.
- [ ] I can perform CRUD operations.
- [ ] I can add validations.
- [ ] I can add simple scopes.

---

## 8) Common Mistakes

| Mistake | Fix |
|---|---|
| Skipping validations | Add model validations |
| Loading too much data | Select only needed records |
| Writing repeated queries | Use named scopes |

---

## 9) Debug Flow

```
Unexpected records?
  -> inspect generated SQL logs
Validation failing?
  -> check errors.full_messages
Slow query?
  -> add indexes + simplify query path
```

---

## 10) Stretch Goal

Define a model with one validation and one scope, then verify behavior in Rails console.
