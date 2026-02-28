# Learning Path 🗓️

> Week-by-week pacing plan for working through all 39 lessons.

---

## The Learning Loop

Every lesson follows this cycle:

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│   Lesson → Apply → Project → Refactor → Reference → Improve │
│      ↑                                             │        │
│      └─────────────────────────────────────────────┘        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**What each step means:**

| Step | What to do |
|------|-----------|
| **Lesson** | Read the README, run the examples, understand the concept |
| **Apply** | Complete the exercises in `exercises.rb` |
| **Project** | Apply the concept to the phase project |
| **Refactor** | Look at `solutions.rb`, compare, improve your code |
| **Reference** | Add anything you want to remember to your notes |
| **Improve** | Do the bonus challenges or create your own exercises |

---

## Week-by-Week Plan

### Week 1 — Setup + Ruby Foundations

**Goal:** Get your environment ready and write your first Ruby programs.

- Day 1: Complete [SETUP.md](../SETUP.md). Verify Ruby 3.2.0 works.
- Day 2: Lesson 01 — Variables, Data Types, Output
- Day 3: Lesson 02 — Strings and String Methods
- Day 4: Lesson 03 — Arrays and Hashes (part 1)
- Day 5: Lesson 03 — Arrays and Hashes (part 2) + review
- Weekend: Skim [ruby_mental_models.md](ruby_mental_models.md)

**You'll know you're ready when:**
- [ ] You can run a Ruby file from the terminal
- [ ] You understand the difference between puts, print, and p
- [ ] You can create and manipulate strings, arrays, and hashes

---

### Week 2 — Control Flow and Methods

**Goal:** Make programs that make decisions and reuse code.

- Day 1: Lesson 04 — Control Flow and Loops
- Day 2: Lesson 04 — Practice exercises
- Day 3: Lesson 05 — Methods and Procs
- Day 4: Lesson 05 — Blocks and Lambdas
- Day 5: Review + start Project 1 planning
- Weekend: Read [cheatsheets/ruby_core_quickref.md](../cheatsheets/ruby_core_quickref.md)

**You'll know you're ready when:**
- [ ] You can write if/elsif/else and case/when
- [ ] You can write a method that accepts a block
- [ ] You understand the difference between a proc and a lambda

---

### Week 3 — Modules, Files, and Errors

**Goal:** Organize code, work with files, and handle errors gracefully.

- Day 1: Lesson 06 — Modules and Mixins
- Day 2: Lesson 06 — Practice exercises
- Day 3: Lesson 07 — File I/O and Parsing
- Day 4: Lesson 08 — Error Handling
- Day 5: Lesson 09 — Gems and Bundler
- Weekend: Work on Project 1 (CLI Tool)

**You'll know you're ready when:**
- [ ] You can include a module into a class
- [ ] You can read from and write to a CSV or text file
- [ ] You can rescue specific exceptions and re-raise when appropriate
- [ ] You can add a gem to a Gemfile and use it

---

### Week 4 — Project 1 + OOP Preview

**Goal:** Complete your first Ruby project and preview OOP concepts.

- Day 1–3: Finish and polish Project 1 (CLI Tool)
- Day 4: Read [oop_mental_models.md](oop_mental_models.md)
- Day 5: Preview Lesson 10 — Classes and Objects
- Weekend: Rest + reflect on what you've learned

**You'll know you're ready when:**
- [ ] Project 1 is complete and runs without errors
- [ ] You can explain what a class is in your own words
- [ ] You're comfortable using Bundler and running RSpec tests

---

### Week 5 — OOP Fundamentals

**Goal:** Understand classes, objects, and inheritance.

- Day 1: Lesson 10 — Classes and Objects
- Day 2: Lesson 11 — Inheritance
- Day 3: Lesson 12 — Modules as Mixins
- Day 4: Lesson 13 — Comparable and Enumerable
- Day 5: Practice + review
- Weekend: Read [cheatsheets/oop_quickref.md](../cheatsheets/oop_quickref.md)

---

### Week 6 — OOP Patterns and Principles

**Goal:** Write better OOP code with patterns and SOLID principles.

- Day 1: Lesson 14 — Design Patterns
- Day 2: Lesson 15 — SOLID Principles
- Day 3: Lesson 16 — Composition
- Day 4: Lesson 17 — Duck Typing
- Day 5: Review + Project 2 planning
- Weekend: Read [templates/ruby_class_template.rb](../templates/ruby_class_template.rb)

---

### Week 7 — Metaprogramming + OOP Project

**Goal:** Peek under the hood and finish the OOP project.

- Day 1: Lesson 18 — Metaprogramming Intro
- Day 2: Lesson 19 — Open Classes
- Day 3: Lesson 20 — OOP Review
- Day 4–5: Work on Project 2 (OOP Application)
- Weekend: Finish Project 2

---

### Week 8 — Rails Introduction

**Goal:** Create your first Rails app and understand MVC.

- Day 1: Read [rails_mental_models.md](rails_mental_models.md)
- Day 2: Lesson 21 — Rails Intro (`rails new myapp`)
- Day 3: Lesson 22 — MVC Overview
- Day 4: Read [rails_architecture.md](rails_architecture.md)
- Day 5: Lesson 23 — Routing
- Weekend: Review [cheatsheets/rails_quickref.md](../cheatsheets/rails_quickref.md)

---

### Weeks 9–10 — Rails Core

**Goal:** Build CRUD functionality with controllers, views, and ActiveRecord.

- Lesson 24 — Controllers
- Lesson 25 — Views and ERB
- Lesson 26 — ActiveRecord Basics
- Lesson 27 — Associations
- Lesson 28 — Validations
- Lesson 29 — Migrations
- Reference: [activerecord_reference.md](activerecord_reference.md)

---

### Weeks 11–12 — Rails Features

**Goal:** Add forms, authentication, authorization, and API endpoints.

- Lesson 30 — Forms
- Lesson 31 — Authentication
- Lesson 32 — Authorization
- Lesson 33 — API Basics

---

### Weeks 13–14 — Testing and Advanced Rails

**Goal:** Write tests and use advanced Rails patterns.

- Lesson 34 — Testing Rails
- Lesson 35 — Service Objects
- Lesson 36 — Background Jobs
- Lesson 37 — Action Mailer
- Reference: [testing_reference.md](testing_reference.md)

---

### Weeks 15–16 — Deployment + Projects

**Goal:** Deploy your app and build the capstone projects.

- Lesson 38 — Deployment
- Lesson 39 — Rails Review
- Project 3 — Full Rails App
- Project 4 — API-Only App

---

## What to Do When Stuck

Follow this protocol in order:

```
1. Read the error message carefully — all of it
       ↓
2. Check the debugging checklist (docs/debugging_checklist.md)
       ↓
3. Search the relevant cheatsheet for the concept
       ↓
4. Search the relevant reference doc (activerecord, routing, etc.)
       ↓
5. Add `binding.pry` or `puts` statements to inspect values
       ↓
6. Search for the error message on Google or Stack Overflow
       ↓
7. Ask GitHub Copilot Chat: "Explain this error: [paste error]"
       ↓
8. Take a break — seriously. Come back fresh.
       ↓
9. Explain the problem out loud (rubber duck debugging)
       ↓
10. Post in a Ruby/Rails community forum
```

**Rules for getting unstuck:**
- Spend no more than 25 minutes stuck before moving to the next step
- Always paste the full error message, not just the last line
- Always include the code context when asking for help
- If you skip a step, you're making it harder for yourself

---

## Tracking Your Progress

Update [ROADMAP.md](../ROADMAP.md) weekly. It takes 2 minutes and keeps you motivated.

**Signs you're on track:**
- You can explain each completed concept without looking at notes
- Your exercises run without errors
- You feel slightly bored reviewing completed lessons (that means you learned them!)

**Signs you need to slow down:**
- Lessons feel confusing even after re-reading
- You're copying solutions without understanding them
- You feel overwhelmed by the number of remaining lessons

**When to speed up:**
- A topic comes very naturally to you — spend less time, move on
- You already know this from another language — skim and practice

---

## Daily Study Tips

- **30 minutes is better than 0** — even short sessions compound
- **Code every day, even if just 15 minutes** — muscle memory matters
- **Review yesterday's work before starting today's** — spaced repetition
- **Write code by hand sometimes** — builds deeper understanding
- **Explain concepts out loud** — if you can't explain it, you don't know it
