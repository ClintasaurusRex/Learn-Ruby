# Lesson 05 — Methods, Procs, and Lambdas

---

## 1) Concept Overview

Methods are reusable blocks of code you name and call by that name.
Procs and Lambdas are objects that *hold* a block so you can pass it around.
Ruby treats code as data — you can store behavior in a variable just like a number.
Lambdas are strict about arguments; Procs are flexible.
`yield` lets a method hand control to a caller-supplied block.

---

## 2) Mental Model Diagram

```
METHOD            PROC              LAMBDA
─────────         ──────────        ─────────────
def greet         greeter =         greeter =
  "Hello"         Proc.new {        lambda {
end               "Hello"           "Hello"
                  }                 }

greet             greeter.call      greeter.call
  │                   │                 │
  └─ lives in         └─ lives in a     └─ like a method:
     the class           variable          checks arg count
     namespace                             has own return

            YIELD
            ──────────────────────────────
            def run_it
              yield if block_given?       ← hands off to caller's block
            end

            run_it { puts "I ran!" }      ← caller provides the block
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# --- Basic method ---
def greet(name)
  "Hello, #{name}!"
end

puts greet("Alice")   # => "Hello, Alice!"

# --- Method with default argument ---
def greet_with_title(name, title: "Friend")
  "Hello, #{title} #{name}!"
end

puts greet_with_title("Bob")               # => "Hello, Friend Bob!"
puts greet_with_title("Bob", title: "Dr.") # => "Hello, Dr. Bob!"

# --- Proc ---
shout = Proc.new { |text| text.upcase }
puts shout.call("hello")   # => "HELLO"

# --- Lambda ---
double = lambda { |n| n * 2 }
puts double.call(5)   # => 10

# --- Yield ---
def wrap_in_stars
  puts "***"
  yield if block_given?
  puts "***"
end

wrap_in_stars { puts "content" }
```

---

## 4) You Type This

Open `starter.rb` and complete the TODOs. Then try:

1. Write a method `calculate(a, b, operation:)` that accepts two numbers and a keyword for the operation (`:add`, `:subtract`, `:multiply`).
2. Write a Proc called `titleize` that capitalizes every word in a string.
3. Write a Lambda called `safe_divide` that returns `nil` if the divisor is zero.
4. Write a method `repeat(n)` that yields a block `n` times.

---

## 5) Expand the Example

**Procs vs Lambdas — key differences:**

```ruby
# Lambda enforces argument count
strict = lambda { |x, y| x + y }
strict.call(1, 2)   # => 3
# strict.call(1)    # ArgumentError!

# Proc is flexible
loose = Proc.new { |x, y| "#{x}, #{y}" }
loose.call(1)       # => "1, "  (y is nil, no error)

# Return behavior differs
def test_proc
  p = Proc.new { return "from proc" }
  p.call
  "after proc"   # never reached
end

def test_lambda
  l = lambda { return "from lambda" }
  l.call
  "after lambda"   # IS reached — lambda return stays inside lambda
end
```

**Method objects:**

```ruby
def square(n) = n ** 2

m = method(:square)   # grab a reference to the method
[1, 2, 3, 4].map(&m)  # => [1, 4, 9, 16]
```

---

## 6) Real-World Application

> *"How would you use this at work?"*

- **Methods** — every feature you write is a method. Keep them short and single-purpose.
- **Procs/Lambdas** — pass custom sorting logic, filtering logic, or callbacks without repeating code.
- **Yield** — used constantly in Ruby: `File.open`, `ActiveRecord::Base.transaction`, custom DSLs.
- **`&:symbol`** — `users.map(&:email)` extracts a field from every object. Used daily in Rails.

```ruby
# Real-world: filter and transform a list of orders
orders = [
  { id: 1, total: 50.0, paid: true },
  { id: 2, total: 120.0, paid: false },
  { id: 3, total: 30.0, paid: true }
]

paid_totals = orders
  .select { |o| o[:paid] }
  .map    { |o| o[:total] }

puts paid_totals.sum   # => 80.0
```

---

## 7) Checklist

Before moving on, confirm you can:

- [ ] Define a method with positional, default, and keyword arguments
- [ ] Use `*args` to accept a variable number of arguments
- [ ] Create a Proc with `Proc.new` and call it with `.call`
- [ ] Create a Lambda with `lambda {}` or `->() {}`
- [ ] Explain the two differences between a Proc and a Lambda
- [ ] Use `yield` inside a method to run a caller-supplied block
- [ ] Use `block_given?` to make the block optional
- [ ] Convert a method to a block with `&method(:name)`
- [ ] Use `&:symbol` shorthand (e.g., `map(&:upcase)`)

---

## 8) Common Mistakes

| Mistake | Fix |
|---------|-----|
| `greet("Alice", "Bob")` when method only takes 1 arg | Use `*names` splat or define two params |
| Forgetting `block_given?` — crashes if no block passed | Always guard with `yield if block_given?` |
| Confusing `return` in Proc vs Lambda | Lambda `return` stays local; Proc `return` exits the enclosing method |
| `proc.call` vs `proc.()` vs `proc[]` | All identical — pick one style and be consistent |
| Passing too many args to a Lambda | Lambda raises `ArgumentError`; check your arg count |
| Defining a method inside a loop | Define methods at the top level or inside a class, not in loops |

---

## 9) Debug Flow

```
Method not found?
  └─ Check spelling, check the method is defined BEFORE it's called
  └─ Check you're calling it on the right object

Wrong number of arguments?
  └─ Count your params: def foo(a, b) needs exactly 2 args
  └─ Use default args or *args if count varies

Proc/Lambda not behaving?
  └─ puts proc.class  # Proc or Proc (lambda: true)?
  └─ puts proc.lambda?  # true = lambda, false = proc
  └─ Check argument count for lambdas

yield: no block given (LocalJumpError)?
  └─ Add `if block_given?` guard
  └─ Or make sure the caller is passing a block { }
```

---

## 10) Stretch Goal

Build a mini **pipeline** system:

```ruby
# A pipeline takes an array of lambdas and runs them in sequence
# Each lambda receives the output of the previous one

def pipeline(value, *steps)
  steps.reduce(value) { |result, step| step.call(result) }
end

strip    = ->(s) { s.strip }
upcase   = ->(s) { s.upcase }
exclaim  = ->(s) { "#{s}!" }

result = pipeline("  hello world  ", strip, upcase, exclaim)
puts result   # => "HELLO WORLD!"
```

Extend it: add a `repeat(n)` step that duplicates the string `n` times.
