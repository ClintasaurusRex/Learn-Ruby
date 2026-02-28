# Learn-Ruby 🔴

[![Ruby](https://img.shields.io/badge/Ruby-3.2.0-red?logo=ruby)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-7.1-cc0000?logo=rubyonrails)](https://rubyonrails.org/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active-brightgreen)]()
[![Platform](https://img.shields.io/badge/Platform-Linux%20Mint-87CF3E?logo=linux)](https://linuxmint.com/)

> A structured, self-paced Ruby → Rails learning journey.  
> Built for Linux Mint. Optimized for VS Code + GitHub Copilot.

---

## 🚀 Quick Start (Linux Mint)

```bash
# Clone the repo
git clone https://github.com/ClintasaurusRex/Learn-Ruby.git
cd Learn-Ruby

# Install rbenv and Ruby 3.2.0
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc && source ~/.bashrc
rbenv install 3.2.0 && rbenv global 3.2.0

# Install dependencies
gem install bundler
bundle install

# Run a lesson
make lesson N=01

# Run tests
make test
```

---

## 📂 Repo Tree

```
Learn-Ruby/
├── README.md               ← You are here
├── ROADMAP.md              ← 39 lessons + 4 projects tracker
├── SETUP.md                ← Linux Mint setup guide
├── Gemfile                 ← RSpec, Pry, Rubocop, Colorize
├── .ruby-version           ← 3.2.0
├── .gitignore
├── Makefile                ← make setup / test / lesson / project
│
├── phase_01_ruby_core/     ← Lessons 01–09 (DO NOT EDIT)
│   ├── 05_methods_and_procs/
│   ├── 06_modules_and_mixins/
│   ├── 07_file_io_and_parsing/
│   ├── 08_error_handling/
│   └── 09_gems_and_bundler/
│
├── phase_02_oop/           ← Lessons 10–20 (coming soon)
│   ├── 10_classes_and_objects/
│   ├── 11_inheritance/
│   ├── 12_modules_as_mixins/
│   ├── 13_comparable_enumerable/
│   ├── 14_design_patterns/
│   ├── 15_solid_principles/
│   ├── 16_composition/
│   ├── 17_duck_typing/
│   ├── 18_metaprogramming_intro/
│   ├── 19_open_classes/
│   └── 20_oop_project/
│
├── phase_03_rails/         ← Lessons 21–39 (coming soon)
│   ├── 21_rails_intro/
│   ├── 22_mvc_overview/
│   ├── 23_routing/
│   ├── 24_controllers/
│   ├── 25_views_and_erb/
│   ├── 26_activerecord_basics/
│   ├── 27_associations/
│   ├── 28_validations/
│   ├── 29_migrations/
│   ├── 30_forms/
│   ├── 31_authentication/
│   ├── 32_authorization/
│   ├── 33_api_basics/
│   ├── 34_testing_rails/
│   ├── 35_service_objects/
│   ├── 36_background_jobs/
│   ├── 37_action_mailer/
│   ├── 38_deployment/
│   ├── 39_rails_project/
│   └── projects/
│
├── docs/                   ← Mental models, references, guides
│   ├── README.md
│   ├── TABLE_OF_CONTENTS.md
│   ├── LEARNING_PATH.md
│   ├── ruby_mental_models.md
│   ├── oop_mental_models.md
│   ├── rails_mental_models.md
│   ├── rails_architecture.md
│   ├── activerecord_reference.md
│   ├── routing_reference.md
│   ├── testing_reference.md
│   ├── debugging_checklist.md
│   └── glossary.md
│
├── cheatsheets/            ← Quick reference cards
│   ├── ruby_core_quickref.md
│   ├── oop_quickref.md
│   ├── rails_quickref.md
│   ├── activerecord_quickref.md
│   ├── rspec_quickref.md
│   └── common_patterns.md
│
└── templates/              ← Boilerplate starters
    ├── ruby_script_template.rb
    ├── ruby_class_template.rb
    ├── rails_service_object_template.rb
    ├── rails_concern_template.rb
    └── rspec_test_template.rb
```

---

## 📚 Phase Overviews

### Phase 1 — Ruby Core (Lessons 01–09)

Master the foundations: syntax, data types, control flow, methods, blocks, procs, lambdas, modules, file I/O, error handling, and gems.

| Lesson | Topic |
|--------|-------|
| 01 | Variables, Data Types, Output |
| 02 | Strings and String Methods |
| 03 | Arrays and Hashes |
| 04 | Control Flow and Loops |
| 05 | Methods and Procs |
| 06 | Modules and Mixins |
| 07 | File I/O and Parsing |
| 08 | Error Handling |
| 09 | Gems and Bundler |

### Phase 2 — OOP (Lessons 10–20)

Build confidence with classes, inheritance, mixins, design patterns, SOLID principles, metaprogramming, and a capstone OOP project.

| Lesson | Topic |
|--------|-------|
| 10 | Classes and Objects |
| 11 | Inheritance |
| 12 | Modules as Mixins |
| 13 | Comparable and Enumerable |
| 14 | Design Patterns |
| 15 | SOLID Principles |
| 16 | Composition |
| 17 | Duck Typing |
| 18 | Metaprogramming Intro |
| 19 | Open Classes |
| 20 | OOP Project |

### Phase 3 — Rails (Lessons 21–39)

Go full-stack: MVC, routing, controllers, views, ActiveRecord, associations, validations, authentication, APIs, testing, service objects, deployment, and a capstone Rails project.

| Lesson | Topic |
|--------|-------|
| 21 | Rails Intro |
| 22 | MVC Overview |
| 23 | Routing |
| 24 | Controllers |
| 25 | Views and ERB |
| 26 | ActiveRecord Basics |
| 27 | Associations |
| 28 | Validations |
| 29 | Migrations |
| 30 | Forms |
| 31 | Authentication |
| 32 | Authorization |
| 33 | API Basics |
| 34 | Testing Rails |
| 35 | Service Objects |
| 36 | Background Jobs |
| 37 | Action Mailer |
| 38 | Deployment |
| 39 | Rails Project |

---

## 🤖 How to Use Copilot to Extend This Repo

GitHub Copilot can help you extend this repo in many ways:

**Generate a new lesson:**
```
# Copilot prompt in VS Code:
# "Create a new Ruby lesson on [topic] following the pattern in phase_01_ruby_core/05_methods_and_procs/"
```

**Get unstuck on an exercise:**
```
# Highlight your code and ask:
# "What's wrong with this Ruby method? Explain it like I'm a beginner."
```

**Add tests:**
```
# In a test file, type:
# "Write RSpec tests for the class above using describe/context/it blocks"
```

**Refactor code:**
```
# Highlight a method and ask:
# "Refactor this Ruby code to be more idiomatic using Enumerable methods"
```

**Tips:**
- Keep Copilot Chat open in a sidebar panel while you code
- Ask it to explain error messages in plain English
- Use it to generate additional practice exercises for any lesson
- Ask "What would a senior Ruby developer do differently here?"

---

## 🐧 Linux Mint Notes

- Use **rbenv** (not rvm) for Ruby version management — it's simpler on Mint
- VS Code extensions to install: `rebornix.Ruby`, `shopify.ruby-lsp`, `misogi.ruby-rubocop`
- If `gem install` fails with permission errors, never use `sudo gem install` — fix your rbenv PATH instead
- See [SETUP.md](SETUP.md) for the complete step-by-step guide
- Tested on Linux Mint 21.x (Ubuntu 22.04 base)

---

## 📖 Docs & References

| Resource | What it covers |
|----------|---------------|
| [ROADMAP.md](ROADMAP.md) | Full lesson tracker with time estimates |
| [SETUP.md](SETUP.md) | Step-by-step Linux Mint setup |
| [docs/LEARNING_PATH.md](docs/LEARNING_PATH.md) | Week-by-week pacing plan |
| [docs/ruby_mental_models.md](docs/ruby_mental_models.md) | How to think about Ruby |
| [docs/oop_mental_models.md](docs/oop_mental_models.md) | How to think about OOP |
| [docs/rails_mental_models.md](docs/rails_mental_models.md) | How to think about Rails |
| [cheatsheets/](cheatsheets/) | Quick reference cards |
| [templates/](templates/) | Boilerplate starters |

---

## 📝 License

MIT — see [LICENSE](LICENSE) for details.
