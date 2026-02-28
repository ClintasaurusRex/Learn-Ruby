# Lesson 01 — Ruby Basics

---

## 1) Concept Overview

Ruby has 6 core data types: String, Integer, Float, Boolean (true/false), nil, and Symbol.
Variables are assigned with `=` and need no type declaration — Ruby infers the type.
Arithmetic operators (`+`, `-`, `*`, `/`, `%`, `**`) work as expected; integer division truncates.
Comparison operators (`==`, `!=`, `<`, `>`, `<=`, `>=`) always return true or false.
Type conversion methods (`.to_i`, `.to_f`, `.to_s`) let you switch between types safely.

---

## 2) Mental Model Diagram

```
  RUBY DATA TYPES
  ───────────────────────────────────────────────────────
  "hello"       → String      (text, in quotes)
  42            → Integer     (whole number)
  3.14          → Float       (decimal number)
  true / false  → TrueClass / FalseClass   (boolean)
  nil           → NilClass    (absence of a value)
  :name         → Symbol      (lightweight, immutable label)

  VARIABLE ASSIGNMENT
  ───────────────────────────────────────────────────────
  greeting = "Hello"     # greeting now holds "Hello"
  count    = 0           # count holds Integer 0
  price    = 9.99        # price holds Float 9.99
  active   = true        # active holds true (TrueClass)
  nothing  = nil         # nothing holds nil (NilClass)
  status   = :pending    # status holds Symbol :pending

  ARITHMETIC
  ───────────────────────────────────────────────────────
  10 + 3  → 13     (add)
  10 - 3  → 7      (subtract)
  10 * 3  → 30     (multiply)
  10 / 3  → 3      (integer division — truncates!)
  10.0/3  → 3.333  (float division — use .to_f)
  10 % 3  → 1      (modulo — remainder)
  10 ** 3 → 1000   (exponent — power)

  TYPE CONVERSION
  ───────────────────────────────────────────────────────
  "42".to_i   → 42       String → Integer
  "3.14".to_f → 3.14     String → Float
  42.to_s     → "42"     Integer → String
  3.14.to_i   → 3        Float → Integer (truncates)
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# --- Data types ---
name    = "Alice"
age     = 30
height  = 5.7
active  = true
nothing = nil
role    = :admin

puts name.class    # => String
puts age.class     # => Integer
puts height.class  # => Float
puts active.class  # => TrueClass
puts nothing.class # => NilClass
puts role.class    # => Symbol

# --- Arithmetic ---
a, b = 10, 3
puts a + b    # => 13
puts a - b    # => 7
puts a * b    # => 30
puts a / b    # => 3   (integer division)
puts a % b    # => 1
puts a ** b   # => 1000

# --- Comparisons ---
puts a == b   # => false
puts a > b    # => true
puts a < b    # => false

# --- Type conversion ---
puts "42".to_i      # => 42
puts "3.14".to_f    # => 3.14
puts 42.to_s        # => "42"
puts 10.to_f / 3    # => 3.3333...
```

---

## 4) You Type This

Open `starter.rb` and complete the TODOs. Then try:

1. Assign one variable of each of the 6 data types and print `.class` for each.
2. Write an expression that uses all 6 arithmetic operators on two numbers.
3. Compare two numbers with all 6 comparison operators and print the results.
4. Convert the string `"100"` to an Integer, then to a Float, then back to a String.

---

## 5) Expand the Example

**Integer vs Float division — a common trap:**

```ruby
# Integer division silently drops the decimal
puts 7 / 2      # => 3  (NOT 3.5 — truncated!)
puts 7.0 / 2    # => 3.5
puts 7 / 2.0    # => 3.5
puts 7.to_f / 2 # => 3.5  (convert first, then divide)

# Modulo reveals the remainder — useful for even/odd checks
puts 10 % 2     # => 0  (even)
puts 11 % 2     # => 1  (odd)

# Exponentiation
puts 2 ** 10    # => 1024
puts 9 ** 0.5   # => 3.0  (square root via fractional exponent)
```

**Symbols vs Strings:**

```ruby
# Symbols are immutable, memory-efficient labels
status = :active      # use for categories, keys, identifiers
label  = "active"     # use for text you'll manipulate

:active == :active    # => true  (always the same object in memory)
"active" == "active"  # => true  (but two different objects)

# Symbols are commonly used as Hash keys
user = { name: "Alice", role: :admin }
```

**nil is not zero or false — it means "nothing":**

```ruby
result = nil
puts result.nil?        # => true
puts result.inspect     # => "nil"
puts result.to_i        # => 0   (safe conversion)
puts result.to_s        # => ""  (safe conversion)
puts result.to_a        # => []  (safe conversion)
```

---

## 6) Real-World Application

> *"How would you use this at work?"*

- **Strings** — user names, messages, file contents, API responses.
- **Integers** — counts, IDs, quantities, line numbers.
- **Floats** — prices, percentages, coordinates, measurements.
- **Booleans** — feature flags, `user.active?`, permission checks.
- **nil** — missing database fields, optional config values, "not found" results.
- **Symbols** — Hash keys in Rails models, method options, status values.

```ruby
# Real-world: process a CSV row of product data
row = { name: "Widget", price: "19.99", qty: "5", active: "true" }

name   = row[:name]
price  = row[:price].to_f
qty    = row[:qty].to_i
active = row[:active] == "true"
total  = price * qty

puts "#{name}: $#{total} (active: #{active})"
# => Widget: $99.95 (active: true)
```

---

## 7) Checklist

Before moving on, confirm you can:

- [ ] Name all 6 Ruby data types and give an example of each
- [ ] Explain why `7 / 2` gives `3` and how to get `3.5`
- [ ] Use all 6 arithmetic operators (`+`, `-`, `*`, `/`, `%`, `**`)
- [ ] Use all 6 comparison operators and know they return `true` or `false`
- [ ] Convert between String, Integer, and Float with `.to_i`, `.to_s`, `.to_f`
- [ ] Explain the difference between `nil` and `false`
- [ ] Explain the difference between a Symbol and a String
- [ ] Use `.class` to inspect a value's type at runtime

---

## 8) Common Mistakes

| Mistake | Fix |
|---------|-----|
| `7 / 2` returns `3` instead of `3.5` | Use `7.to_f / 2` or `7 / 2.0` |
| `"5" + 3` raises `TypeError` | Convert first: `"5".to_i + 3` |
| Confusing `nil` with `false` | `nil` means "nothing exists"; `false` means "no" |
| Using a String where a Symbol is expected as a Hash key | Use `:key` not `"key"` for symbol keys |
| `"abc".to_i` returns `0`, not an error | Ruby returns `0` when conversion fails — validate input |
| `10 ** -1` returns `0` (Integer exponent) | Use `10.0 ** -1` for `0.1` |

---

## 9) Debug Flow

```
Unexpected type error?
  └─ Check value.class — what type do you actually have?
  └─ Add .to_i / .to_f / .to_s to convert before operating

Getting 0 from a string conversion?
  └─ "abc".to_i => 0 — the string doesn't start with a digit
  └─ Validate input or use Integer("abc") which raises an error

Integer division giving wrong answer?
  └─ puts 7/2 gives 3 — add .to_f to one operand: 7.to_f/2

nil showing up unexpectedly?
  └─ puts variable.inspect  # shows nil vs "" vs 0
  └─ Add .nil? check before using the value
  └─ Use .to_i / .to_s / .to_a for safe nil → default conversions

Wrong comparison result?
  └─ Check you're using == not = (assignment vs comparison)
  └─ puts a.class, b.class — comparing String "3" to Integer 3 is false
```

---

## 10) Stretch Goal

Build a mini **unit converter**:

```ruby
# Convert temperatures between Celsius and Fahrenheit
to_fahrenheit = ->(c) { (c * 9.0 / 5) + 32 }
to_celsius    = ->(f) { (f - 32) * 5.0 / 9 }

puts to_fahrenheit.call(0)     # => 32.0
puts to_fahrenheit.call(100)   # => 212.0
puts to_celsius.call(98.6).round(1)   # => 37.0

# Sample output:
# 0°C = 32.0°F
# 100°C = 212.0°F
# 98.6°F = 37.0°C
```

Extend it: add a converter for miles ↔ kilometres (`1 mile = 1.60934 km`).
