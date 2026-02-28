# Documentation Hub 📚

> Start here. Everything you need to learn Ruby and Rails.

---

## 🚀 Start-Here Checklist

Before diving into lessons, do these first:

- [ ] Complete [SETUP.md](../SETUP.md) — get Ruby 3.2.0 running
- [ ] Read [LEARNING_PATH.md](LEARNING_PATH.md) — understand the weekly plan
- [ ] Skim [ruby_mental_models.md](ruby_mental_models.md) — build intuition early
- [ ] Bookmark [TABLE_OF_CONTENTS.md](TABLE_OF_CONTENTS.md) — your navigation map
- [ ] Check your progress in [ROADMAP.md](../ROADMAP.md)

---

## 📂 Navigation

| Document | What It's For |
|----------|--------------|
| [TABLE_OF_CONTENTS.md](TABLE_OF_CONTENTS.md) | Full linked index of every lesson, doc, and cheatsheet |
| [LEARNING_PATH.md](LEARNING_PATH.md) | Week-by-week plan with pacing guidance |
| [ruby_mental_models.md](ruby_mental_models.md) | How to think about Ruby (objects, scope, blocks, etc.) |
| [oop_mental_models.md](oop_mental_models.md) | How to think about OOP (classes, inheritance, mixins) |
| [rails_mental_models.md](rails_mental_models.md) | How to think about Rails (MVC, request lifecycle) |
| [rails_architecture.md](rails_architecture.md) | Full MVC flow, folder structure, where code belongs |
| [activerecord_reference.md](activerecord_reference.md) | CRUD, associations, validations, callbacks, scopes |
| [routing_reference.md](routing_reference.md) | RESTful routes, nested routes, path helpers |
| [testing_reference.md](testing_reference.md) | RSpec structure, matchers, mocks, request specs |
| [debugging_checklist.md](debugging_checklist.md) | Step-by-step debugging for Ruby and Rails |
| [glossary.md](glossary.md) | 40+ plain-language definitions |

---

## 🛤️ Learning Paths

### Beginner Path
*You're new to Ruby or programming.*

1. [SETUP.md](../SETUP.md) — get your environment ready
2. [ruby_mental_models.md](ruby_mental_models.md) — understand how Ruby thinks
3. `phase_01_ruby_core/` — lessons 01–09 in order
4. [debugging_checklist.md](debugging_checklist.md) — learn to debug early
5. [cheatsheets/ruby_core_quickref.md](../cheatsheets/ruby_core_quickref.md) — quick reference

### Intermediate Path
*You know Ruby basics and want to move to OOP or Rails.*

1. [oop_mental_models.md](oop_mental_models.md) — OOP intuition
2. `phase_02_oop/` — lessons 10–20
3. [rails_mental_models.md](rails_mental_models.md) — Rails intuition
4. [rails_architecture.md](rails_architecture.md) — understand the full stack
5. `phase_03_rails/` — lessons 21–39

### Quick Reference Path
*You need to look something up fast.*

- Ruby syntax → [cheatsheets/ruby_core_quickref.md](../cheatsheets/ruby_core_quickref.md)
- OOP patterns → [cheatsheets/oop_quickref.md](../cheatsheets/oop_quickref.md)
- Rails helpers → [cheatsheets/rails_quickref.md](../cheatsheets/rails_quickref.md)
- ActiveRecord → [cheatsheets/activerecord_quickref.md](../cheatsheets/activerecord_quickref.md)
- RSpec → [cheatsheets/rspec_quickref.md](../cheatsheets/rspec_quickref.md)
- Patterns → [cheatsheets/common_patterns.md](../cheatsheets/common_patterns.md)

---

## 🆘 I Forgot Everything, Start Here

**Just got back after a break? Do this:**

1. Open [glossary.md](glossary.md) and read through the terms you've forgotten
2. Open [ruby_mental_models.md](ruby_mental_models.md) and review the ASCII diagrams
3. Run a lesson you already completed: `make lesson N=05`
4. If stuck on an error, go to [debugging_checklist.md](debugging_checklist.md)
5. Check where you left off: [ROADMAP.md](../ROADMAP.md)

**Quick mental reset commands:**

```ruby
# Everything in Ruby is an object
42.class          # => Integer
"hello".class     # => String
nil.class         # => NilClass
true.class        # => TrueClass

# Methods return the last evaluated expression
def double(n)
  n * 2           # this is returned automatically
end

# Blocks are chunks of code you pass to methods
[1, 2, 3].map { |n| n * 2 }   # => [2, 4, 6]
```

---

## 💡 Tips for Using These Docs

- **Don't read linearly** — use them as reference, not textbooks
- **Copy/paste the examples** — then modify them to learn
- **ASCII diagrams are maps** — draw your own versions by hand
- **Common mistakes sections** — read these before you make the mistake
- **Debug tips** — always keep [debugging_checklist.md](debugging_checklist.md) open

---

## 🔗 Related Resources

| Resource | URL |
|----------|-----|
| Ruby Docs | https://ruby-doc.org |
| Rails Guides | https://guides.rubyonrails.org |
| RSpec Docs | https://rspec.info |
| Rubocop Docs | https://rubocop.org |
