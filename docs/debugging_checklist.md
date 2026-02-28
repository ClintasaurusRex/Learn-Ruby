# Debugging Checklist 🐛

> Step-by-step debugging for Ruby and Rails. When you're stuck, follow this checklist.

---

## Mental Model — Debugging Is a Science

```
┌──────────────────────────────────────────────────────────┐
│              DEBUGGING PROCESS                           │
│                                                          │
│  1. Observe  → What exactly is happening?                │
│  2. Hypothesize → What might cause this?                 │
│  3. Test     → Add logging/breakpoints to verify         │
│  4. Conclude → Was your hypothesis correct?              │
│  5. Fix      → Make the minimal change to fix it         │
│  6. Verify   → Confirm the fix works and nothing broke   │
└──────────────────────────────────────────────────────────┘
```

---

## Ruby Debugging Flow

```
Error occurs
     │
     ▼
1. Read the full error message (not just the last line)
     │
     ▼
2. Find the line number in YOUR code (skip library frames)
     │
     ▼
3. Check the type of error:
   - NoMethodError    → called method on nil? Check what's nil
   - NameError        → variable/method not defined? Typo? Scope?
   - ArgumentError    → wrong number of arguments?
   - TypeError        → wrong type? (e.g., nil + 1)
   - LoadError        → missing file or gem?
   - SyntaxError      → mismatched do/end, missing comma?
     │
     ▼
4. Add puts/p statements to inspect values
   puts user.inspect
   p params
     │
     ▼
5. Add a pry breakpoint
   require 'pry'; binding.pry
     │
     ▼
6. Check your assumptions: is it what you think it is?
     │
     ▼
7. Fix and verify
```

---

## Rails Debugging Flow

```
Something doesn't work
     │
     ▼
1. Check server logs (in the terminal running rails server)
   Look for: Started GET "/path", then follow down
     │
     ▼
2. Check the error page (in browser)
   - Read the exception type and message
   - Click "Show full trace" and find your code
     │
     ▼
3. Add binding.pry to the controller action
   def show
     binding.pry   ← add this
     @post = Post.find(params[:id])
   end
     │
     ▼
4. Inspect values in the pry console
   > params
   > @post
   > Post.all
     │
     ▼
5. Check the database: rails console
   Post.find(1)
   Post.count
     │
     ▼
6. Check routes: rails routes | grep post
     │
     ▼
7. Check the view for undefined variable errors
   - Make sure @post is being set in the controller
   - Make sure the view filename matches the action
```

---

## Pry Guide

### Setup

```ruby
# Gemfile
gem 'pry', '~> 0.14'

# In any Ruby file
require 'pry'
binding.pry   # ← execution stops here
```

### Pry Commands

| Command | What it does |
|---------|-------------|
| `ls` | List available methods and variables |
| `ls user` | List methods on user object |
| `cd user` | Change context to user object |
| `cd ..` | Go back up to previous context |
| `show-source MyClass#method` | Show source code of a method |
| `whereami` | Show where you are in the code |
| `next` | Execute next line (step over) |
| `step` | Step into a method call |
| `continue` | Continue execution |
| `exit` | Exit pry and continue (or exit the program) |
| `exit!` | Exit immediately |
| `!!!` | Hard exit |
| `help` | Show all commands |

### Pry in Rails

```ruby
# In a controller
def create
  binding.pry
  @post = Post.new(post_params)
end

# In a model method
def publish!
  binding.pry
  update!(published: true)
end

# In a view (rare, but possible)
<% binding.pry %>
```

---

## Common Error Types

| Error | Likely Cause | Fix |
|-------|-------------|-----|
| `NoMethodError: undefined method 'name' for nil` | Something you expected to be an object is nil | Add nil check: `user&.name` or find where nil comes from |
| `NameError: undefined local variable 'x'` | Typo, wrong scope, or not defined yet | Check spelling, check scope (block vs method) |
| `ArgumentError: wrong number of arguments` | Calling method with wrong args | Check method signature and what you're passing |
| `ActiveRecord::RecordNotFound` | `.find(id)` with invalid id | Use `.find_by` which returns nil, or handle the error |
| `ActiveRecord::RecordInvalid` | Saving invalid record with `!` method | Check `record.errors.full_messages` |
| `ActionController::ParameterMissing` | Required param not in request | Check params hash, check form field names |
| `ActionController::InvalidAuthenticityToken` | CSRF token missing | Add `<%= csrf_meta_tags %>` to layout |
| `LoadError: cannot load such file` | Missing gem or require | Run `bundle install`, check Gemfile |
| `SyntaxError: unexpected end` | Missing `end` keyword | Count your do/def/if vs end |
| `Errno::ENOENT: No such file` | File path is wrong | Check the file path, use `File.exist?(path)` |
| `PG::UndefinedTable` | Migration not run | Run `rails db:migrate` |
| `ActiveModel::MissingAttributeError` | Accessing column that doesn't exist | Check schema.rb, run migration |

---

## Quick Debug Helpers

```ruby
# Inspect any value
puts value.inspect
p value              # same as puts value.inspect

# Inspect multiple values
p [user, post, params]

# Print class and value
puts "#{value.class}: #{value.inspect}"

# Check if something is nil
puts value.nil?
puts value.present?  # Rails: not nil, empty string, or empty array

# Check what methods an object has
puts user.methods.sort.inspect
puts user.respond_to?(:save)

# Check where a method comes from
puts user.method(:save).source_location

# Stop execution here and open a console
require 'pry'; binding.pry

# Ruby console with your app loaded (Rails)
rails console
rails console --sandbox   # changes rolled back on exit
```

**Checklist:**
- [ ] I always read the full error message including the line number
- [ ] I know the most common error types and their causes
- [ ] I can use `puts`/`p` to inspect values
- [ ] I can add `binding.pry` to pause execution and inspect state
- [ ] I know how to use the Rails console to debug database issues
- [ ] I check `rails routes` when I get routing errors
- [ ] I check the server logs when requests fail

**Common debugging mistakes:**
- Reading only the last line of an error (the first line has the most info)
- Not checking what `nil` is before calling methods on it
- Debugging with `puts` and never removing the puts statements (use `pry` instead)
- Changing multiple things at once — change one thing, test, repeat
