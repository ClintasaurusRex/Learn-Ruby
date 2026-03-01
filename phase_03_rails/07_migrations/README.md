# Lesson 07 — Migrations

---

## 1) Concept Overview

Migrations are versioned Ruby files that evolve database schema over time.
They provide a repeatable timeline of structural DB changes.

---

## 2) Mental Model Diagram

### Migration timeline diagram (required)

```
Timestamped files in db/migrate/

20260301010000_create_users.rb
20260301011000_add_role_to_users.rb
20260301012000_create_posts.rb

Applied in timestamp order -> schema moves forward predictably
```

### up/down/change explanation (required)

```
change : reversible migration DSL for simple schema operations
up     : explicit forward migration logic
down   : explicit rollback logic

Use change when reversible.
Use up/down for custom SQL or non-reversible transitions.
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# bin/rails generate migration AddStatusToOrders status:string
# bin/rails db:migrate
# bin/rails db:rollback
```

---

## 4) You Type This

1. Generate a migration.
2. Add one column.
3. Run migrate.
4. Run rollback.

---

## 5) Expand the Example

Create two migrations and inspect `db/schema.rb` after each run.

---

## 6) Real-World Application

Reliable migrations are essential for deployments and team collaboration.

---

## 7) Checklist

- [ ] I can generate a migration file.
- [ ] I can explain migration ordering.
- [ ] I can run migrate and rollback.
- [ ] I know when to use change vs up/down.

---

## 8) Common Mistakes

| Mistake | Fix |
|---|---|
| Editing old migration already run in shared env | Create a new migration instead |
| Non-reversible change inside `change` | Use `up/down` explicitly |
| Ignoring rollback path | Test rollback locally |

---

## 9) Debug Flow

```
Migration failed?
  -> read stack trace and failing SQL
Schema mismatch?
  -> check migration status with bin/rails db:migrate:status
Rollback failed?
  -> ensure down path is valid and complete
```

---

## 10) Stretch Goal

Write a reversible migration adding a column with a default and not-null constraint.
