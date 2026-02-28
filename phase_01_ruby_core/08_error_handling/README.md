# Lesson 08 — Error Handling

---

## 1) Concept Overview

Errors in Ruby are objects that inherit from `Exception`.
`begin/rescue/ensure/end` is the standard error-handling structure.
`raise` throws an error; `rescue` catches it; `ensure` always runs.
Custom exception classes let you create specific, meaningful error types.
Good error handling: catch what you can fix, let the rest bubble up.

---

## 2) Mental Model Diagram

```
THE EXCEPTION HIERARCHY
────────────────────────────────────────────────────────────
Exception
  └─ StandardError          ← rescue catches this and below
       ├─ RuntimeError      ← raise "message" creates this
       ├─ ArgumentError     ← wrong number/type of arguments
       ├─ TypeError         ← wrong type passed
       ├─ NameError
       │    └─ NoMethodError← called method doesn't exist
       ├─ IOError
       │    └─ Errno::ENOENT ← file not found
       ├─ ZeroDivisionError
       ├─ KeyError          ← hash.fetch with missing key
       └─ IndexError        ← array out of bounds

  └─ ScriptError           ← don't rescue these in app code
  └─ SystemExit            ← called by exit / exit!
  └─ SignalException

RULE: Only rescue StandardError (or its children)
      Never rescue Exception — that catches too much!

BEGIN/RESCUE FLOW
────────────────────────────────────────────────────────────
begin
  risky_operation()      ← try this
rescue SpecificError => e  ← if SpecificError happens
  handle_it(e)           ← do this
rescue AnotherError => e   ← if AnotherError happens
  handle_it_differently(e)
ensure
  cleanup()              ← ALWAYS runs (success or failure)
end
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

def divide(a, b)
  raise ArgumentError, "b cannot be zero" if b == 0
  a / b
end

begin
  puts divide(10, 2)    # => 5
  puts divide(10, 0)    # raises ArgumentError
rescue ArgumentError => e
  puts "Caught: #{e.message}"   # => Caught: b cannot be zero
ensure
  puts "Always runs!"
end
```

---

## 4) You Type This

Open `starter.rb` and:

1. Add a custom exception class `ValidationError < StandardError`
2. Write a method `validate_age(age)` that raises `ValidationError` if age is not a positive integer
3. Write a method `fetch_user(id)` that raises `KeyError` if id is not found in a hash
4. Write a method `retry_operation(max_retries:)` that retries a block up to N times on failure
5. Use `ensure` to guarantee a resource is "released"

---

## 5) Expand the Example

**Multiple rescue clauses:**

```ruby
def process(value)
  case value
  when String then Integer(value)   # raises ArgumentError if not a number
  when nil    then raise TypeError, "value cannot be nil"
  else value * 2
  end
rescue ArgumentError => e
  puts "Can't convert '#{value}' to integer: #{e.message}"
  0
rescue TypeError => e
  puts "Type error: #{e.message}"
  -1
end

puts process("42")    # => 84
puts process("abc")   # => 0  (caught ArgumentError)
puts process(nil)     # => -1  (caught TypeError)
```

**Retry pattern:**

```ruby
attempts = 0
begin
  attempts += 1
  raise "Flaky!" if attempts < 3
  puts "Succeeded on attempt #{attempts}"
rescue RuntimeError => e
  puts "Attempt #{attempts} failed: #{e.message}"
  retry if attempts < 3
  raise   # re-raise if we've exhausted retries
end
```

**Custom exceptions with extra data:**

```ruby
class HttpError < StandardError
  attr_reader :status_code

  def initialize(message, status_code)
    super(message)
    @status_code = status_code
  end
end

raise HttpError.new("Not Found", 404)
rescue HttpError => e
  puts "HTTP #{e.status_code}: #{e.message}"
end
```

---

## 6) Real-World Application

> *"How would you use this at work?"*

- **Form validation**: raise custom errors when user input is invalid
- **API calls**: rescue `Net::HTTPError`, log it, return a default
- **File processing**: rescue `Errno::ENOENT`, skip missing files, continue
- **Database operations**: rescue `ActiveRecord::RecordNotFound`, render 404
- **Retry on transient failure**: network calls, external services

```ruby
# Real-world: safe API call with retry
def fetch_data(url, max_retries: 3)
  attempts = 0
  begin
    attempts += 1
    response = HTTP.get(url)
    raise "HTTP #{response.code}" unless response.ok?
    response.body
  rescue => e
    if attempts <= max_retries
      sleep(2 ** attempts)   # exponential backoff
      retry
    end
    raise
  end
end
```

---

## 7) Checklist

Before moving on, confirm you can:

- [ ] Use `begin/rescue/end` to catch errors
- [ ] Use `rescue Error => e` to capture the error object
- [ ] Access the error message with `e.message`
- [ ] Use `ensure` to run cleanup code always
- [ ] Use `raise` to throw an error
- [ ] Use `raise` with no arguments to re-raise the current error
- [ ] Use `retry` inside a rescue block to retry the begin block
- [ ] Define a custom exception class inheriting from `StandardError`
- [ ] Rescue multiple error types in one block
- [ ] Know which errors NOT to rescue (`Exception`, `SystemExit`, `SignalException`)

---

## 8) Common Mistakes

| Mistake | Fix |
|---------|-----|
| `rescue Exception` | Use `rescue StandardError` — Exception catches too much |
| Silently swallowing errors (`rescue; end`) | At minimum log the error: `rescue => e; warn e.message` |
| Rescuing too broadly instead of specifically | Rescue the most specific error first |
| Forgetting `ensure` for cleanup | Use `ensure` for file close, connection release, etc. |
| `retry` without a counter — infinite loop | Always track attempts: `attempts += 1; retry if attempts < 3` |
| `raise` inside `ensure` swallows original error | Avoid `raise` in `ensure` blocks |
| Rescuing inside a method that should propagate | Let errors bubble up unless you can actually handle them |

---

## 9) Debug Flow

```
Unexpected error in production?
  └─ Check e.class and e.message first
  └─ Check e.backtrace.first for file + line number
  └─ puts e.backtrace.join("\n") for full trace

Which error to rescue?
  └─ puts e.class to see the exact class
  └─ Look it up in the exception hierarchy

ensure not running?
  └─ ensure always runs — even after return, even after raise
  └─ If it's not running, check you're inside begin/rescue/ensure/end

retry loop?
  └─ Add a counter: break if attempts >= max
  └─ Add puts to trace retries

Custom exception not caught?
  └─ Make sure it inherits from StandardError (not Exception)
  └─ Check the rescue clause matches the class you're raising
```

---

## 10) Stretch Goal

Build a **Result type** that avoids exceptions for expected failures:

```ruby
class Result
  attr_reader :value, :error

  def initialize(value: nil, error: nil)
    @value = value
    @error = error
  end

  def self.ok(value) = new(value: value)
  def self.err(message) = new(error: message)

  def ok?    = @error.nil?
  def error? = !ok?

  def map
    ok? ? Result.ok(yield(value)) : self
  end
end

def safe_divide(a, b)
  b == 0 ? Result.err("division by zero") : Result.ok(a / b.to_f)
end

result = safe_divide(10, 2).map { |v| v * 100 }
puts result.ok?    # => true
puts result.value  # => 500.0
```
