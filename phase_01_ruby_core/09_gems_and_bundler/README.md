# Lesson 09 — Gems and Bundler

---

## 1) Concept Overview

Gems are packaged Ruby libraries you can download and use in any project.
Bundler manages gem dependencies: which gems, which versions, locked for consistency.
`Gemfile` declares what you need; `Gemfile.lock` records the exact versions installed.
`require "gem_name"` loads a gem's code into your program.
`bundle exec ruby script.rb` ensures the right gem versions are used.

---

## 2) Mental Model Diagram

```
THE GEM ECOSYSTEM
──────────────────────────────────────────────────────────────

rubygems.org                 Your Computer
────────────                 ────────────────────────────────
  gem: colorize  ──install──► ~/.gem/ruby/3.2.0/gems/colorize-1.1.0/
  gem: rspec     ──install──► ~/.gem/ruby/3.2.0/gems/rspec-3.12.0/
  gem: pry       ──install──► ~/.gem/ruby/3.2.0/gems/pry-0.14.0/

BUNDLER'S JOB
──────────────────────────────────────────────────────────────

Gemfile                      Gemfile.lock
──────────────               ──────────────────────────────
gem "colorize", "~> 1.1"  →  colorize (1.1.0)
gem "rspec", "~> 3.12"    →  rspec (3.12.2)
                              rspec-core (3.12.2)
                              rspec-mocks (3.12.6)
                              rspec-support (3.12.1)

VERSION CONSTRAINTS
──────────────────────────────────────────────────────────────
"~> 1.1"    pessimistic: >= 1.1, < 2.0   (allows patch + minor)
"~> 1.1.0"  pessimistic: >= 1.1.0, < 1.2 (allows patch only)
">= 2.0"    at least 2.0
"= 3.12.0"  exactly this version
"< 2.0"     below 2.0
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# In your Gemfile:
#   gem "colorize", "~> 1.1"
#   gem "pry",      "~> 0.14"

# Install with: bundle install
# Run with:     bundle exec ruby starter.rb

require "colorize"

puts "Hello, World!".colorize(:green)
puts "Warning!".colorize(:yellow)
puts "Error!".colorize(:red)
puts "Info".colorize(color: :white, background: :blue)
```

---

## 4) You Type This

Open `starter.rb` and:

1. Use the `colorize` gem to print a formatted status dashboard
2. Use the `json` gem (built-in) to read and write data
3. Add a gem to the Gemfile and use `bundle install` to install it
4. Write a script that uses `optparse` (built-in) to accept command-line args

---

## 5) Expand the Example

**Gemfile version constraints explained:**

```ruby
# Gemfile
source "https://rubygems.org"

ruby "3.2.0"

gem "colorize", "~> 1.1"    # >= 1.1, < 2.0  (safe upgrade path)
gem "rspec",    "~> 3.12"   # >= 3.12, < 4.0
gem "pry",      "~> 0.14"   # >= 0.14, < 1.0

group :development do
  gem "rubocop", "~> 1.60", require: false
end

group :test do
  gem "factory_bot", "~> 6.4"
end
```

**Creating a simple gem with a module:**

```ruby
# lib/my_formatter.rb
module MyFormatter
  def self.header(text)
    "=" * 40 + "\n#{text}\n" + "=" * 40
  end

  def self.bullet(text)
    "  • #{text}"
  end
end
```

**Using `require_relative` for local files:**

```ruby
require_relative "lib/my_formatter"

puts MyFormatter.header("Report")
puts MyFormatter.bullet("Item one")
puts MyFormatter.bullet("Item two")
```

---

## 6) Real-World Application

> *"How would you use this at work?"*

- **HTTParty / Faraday** — HTTP client gems for calling APIs
- **ActiveRecord (standalone)** — use Rails' ORM without the whole Rails stack
- **Sidekiq** — background job processing
- **Dotenv** — load environment variables from `.env` file
- **Nokogiri** — parse HTML/XML
- **Rake** — task runner (like make, but in Ruby)

```ruby
# Gemfile for a typical CLI tool at work
gem "dotenv", "~> 2.8"        # load .env
gem "faraday", "~> 2.7"       # HTTP client
gem "json", ">= 2.0"          # JSON (usually already available)
gem "colorize", "~> 1.1"      # colored terminal output
gem "optparse"                 # command-line argument parsing (built-in)
```

---

## 7) Checklist

Before moving on, confirm you can:

- [ ] Create a `Gemfile` with `source`, `ruby`, and `gem` entries
- [ ] Run `bundle install` to install gems
- [ ] Run `bundle exec ruby script.rb` to use bundled gems
- [ ] Understand `~>` (pessimistic) version constraints
- [ ] Find gems at `rubygems.org`
- [ ] Use `require "gem_name"` to load a gem
- [ ] Use `require_relative "path"` for local files
- [ ] Understand the difference between `Gemfile` and `Gemfile.lock`
- [ ] Use `bundle update gem_name` to update a specific gem
- [ ] Use `gem list` to see installed gems

---

## 8) Common Mistakes

| Mistake | Fix |
|---------|-----|
| Running `ruby script.rb` without `bundle exec` | Use `bundle exec ruby script.rb` to load correct gem versions |
| Committing `Gemfile.lock` for gems — should you? | YES — commit it for apps; `.gitignore` it for gems/libraries |
| `require "wrong_name"` — LoadError | Check the gem's README for the exact require name |
| Forgetting `bundle install` after editing Gemfile | Always run `bundle install` after changing Gemfile |
| Using `>=` instead of `~>` — too permissive | `~>` is safer; it prevents breaking major version changes |
| Mixing `require` and `require_relative` incorrectly | `require` is for gems; `require_relative` is for local files |

---

## 9) Debug Flow

```
LoadError: cannot load such file -- gem_name?
  └─ Did you add it to Gemfile and run bundle install?
  └─ Are you running with bundle exec?
  └─ Check the gem name in the require statement (might differ from gem name)

Bundler::GemNotFound?
  └─ Run: bundle install
  └─ Check your Gemfile syntax

Gem version conflict?
  └─ bundle update gem_name (updates just that gem)
  └─ bundle update (updates everything — risky)
  └─ Check Gemfile.lock for conflicting versions

Wrong Ruby version?
  └─ Check .ruby-version: cat .ruby-version
  └─ Check current: ruby -v
  └─ Switch with: rbenv local 3.2.0
```

---

## 10) Stretch Goal

Build a mini **gem inspector** CLI tool:

```ruby
#!/usr/bin/env ruby
# frozen_string_literal: true
# Usage: bundle exec ruby gem_inspector.rb colorize

require "open3"

gem_name = ARGV.first
unless gem_name
  puts "Usage: #{$PROGRAM_NAME} <gem_name>"
  exit 1
end

stdout, = Open3.capture2("gem info #{gem_name}")
puts stdout
```

Extend it: parse the output and display only the version numbers in a formatted table.
