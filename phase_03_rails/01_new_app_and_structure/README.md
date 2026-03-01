# Lesson 01 — New App and Structure

---

## 1) Concept Overview

A new Rails app is generated with a standard directory layout.
Knowing what each folder does helps you find code quickly and keep concerns separate.

---

## 2) Mental Model Diagram

### Folder structure diagram (required)

```
my_app/
├── app/
│   ├── controllers/
│   ├── models/
│   ├── views/
│   ├── helpers/
│   └── assets/
├── config/
│   ├── routes.rb
│   ├── database.yml
│   └── environments/
├── db/
│   ├── migrate/
│   └── schema.rb
├── test/ or spec/
├── public/
├── Gemfile
└── Rakefile
```

### What each folder does (required)

```
app/       -> application code (MVC, helpers, mailers, jobs)
config/    -> routes, environment settings, initializers
db/        -> migrations + schema + seeds
public/    -> static files served directly
test/spec/ -> automated tests
Gemfile    -> dependency manifest
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# Terminal commands:
# rails new shop --database=sqlite3
# cd shop
# bin/rails generate controller Pages home
# bin/rails server
```

---

## 4) You Type This

1. Generate a fresh app.
2. Open the project tree.
3. Find `config/routes.rb`.
4. Find `app/controllers` and `app/views`.

---

## 5) Expand the Example

Map each file you touch to its folder purpose before editing.
This habit prevents misplaced code and faster code review.

---

## 6) Real-World Application

When joining a new Rails codebase, start with `config/routes.rb`, then inspect matching controllers and views.
This gives you a reliable orientation path in minutes.

---

## 7) Checklist

- [ ] I can create a new Rails app.
- [ ] I can find routes file quickly.
- [ ] I can find controllers and views.
- [ ] I can explain `db/migrate`.
- [ ] I can explain Gemfile purpose.

---

## 8) Common Mistakes

| Mistake | Fix |
|---|---|
| Editing generated files blindly | Read folder intent first |
| Placing classes in wrong directory | Follow Rails naming conventions |
| Ignoring environment configs | Check `config/environments/*` |

---

## 9) Debug Flow

```
Can't find a class?
  -> Verify file path matches constant name
Server boots but route missing?
  -> Check config/routes.rb
Migration not seen?
  -> Confirm file is under db/migrate
```

---

## 10) Stretch Goal

Generate a new app and annotate each top-level folder in your own words.
