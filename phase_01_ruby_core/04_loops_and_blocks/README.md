# Lesson 04 — Loops and Blocks

---

## 1) Concept Overview

Ruby has many ways to loop: counter-based (`times`, `upto`, `downto`), condition-based (`while`, `until`), and collection-based (`each`).
Blocks are anonymous chunks of code passed to a method between `do…end` or `{ }`.
`reduce`/`inject` collapses a collection to a single value by applying a block repeatedly.
`each_with_object` builds up a result object (like a Hash or Array) while iterating.
`yield` lets a method hand control to a caller-supplied block — the foundation of Ruby's iterator pattern.

---

## 2) Mental Model Diagram

```
COUNTER LOOPS              CONDITION LOOPS         COLLECTION LOOPS
──────────────             ───────────────         ────────────────
3.times do |i|             i = 0                   [1,2,3].each do |n|
  puts i        ──►  0     while i < 3               puts n
end             ──►  1       puts i      ──►  0    end
                ──►  2       i += 1      ──►  1              ──►  1
                           end           ──►  2              ──►  2
1.upto(3)  { |i| ... }                                       ──►  3
3.downto(1){ |i| ... }     until done? { ... }

         REDUCE / INJECT                  EACH_WITH_OBJECT
         ──────────────────               ─────────────────
         [1,2,3,4]                        ["cat","bee","ant"]
           .reduce(0) { |sum, n|            .each_with_object({}) do |w, h|
               sum + n                          h[w.length] ||= []
             }          ──►  10               h[w.length] << w
                                          end  ──►  {3=>["cat","ant"],
                                                      3=>..., 2=>["be"..]}

         YIELD
         ─────────────────────────────────────
         def run_it                          ← defines the method
           yield(42) if block_given?        ← passes 42 to caller's block
         end

         run_it { |n| puts n * 2 }          ← caller supplies the block
                  ──►  84
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# --- times ---
5.times { |i| puts "tick #{i}" }

# --- upto / downto ---
1.upto(3)  { |n| puts n }
3.downto(1){ |n| puts n }

# --- while ---
count = 0
while count < 3
  puts count
  count += 1
end

# --- each ---
[10, 20, 30].each { |n| puts n }

# --- reduce ---
sum = [1, 2, 3, 4].reduce(0) { |acc, n| acc + n }
puts sum   # => 10

# --- each_with_object ---
result = [1, 2, 3].each_with_object([]) { |n, arr| arr << n * 2 }
puts result.inspect   # => [2, 4, 6]

# --- yield ---
def call_block
  yield if block_given?
end
call_block { puts "Hello from block!" }
```

---

## 4) You Type This

Open `starter.rb` and complete the TODOs. Then try:

1. Use `downto` to build an Array counting from 10 down to 1.
2. Write a `while` loop that doubles a number until it exceeds 100.
3. Use `each` to sum an Array without calling `.sum`.
4. Use `reduce` to find the product (multiplication) of an Array.
5. Use `each_with_object` to group words by their first letter.
6. Write a method that `yield`s each element multiplied by an index.

---

## 5) Expand the Example

**Chaining iterators:**

```ruby
# reduce with a symbol shorthand
[1, 2, 3, 4, 5].reduce(:+)   # => 15
[1, 2, 3, 4, 5].reduce(:*)   # => 120

# inject is an alias — identical to reduce
[1, 2, 3].inject(10) { |acc, n| acc + n }  # => 16  (starts at 10)

# each_with_object building a frequency map
words = ["apple", "banana", "avocado", "blueberry", "cherry"]
freq  = words.each_with_object(Hash.new(0)) do |word, counts|
  counts[word[0]] += 1
end
puts freq.inspect   # => {"a"=>2, "b"=>2, "c"=>1}

# Passing a block argument explicitly with &block
def repeat(n, &block)
  n.times { |i| block.call(i) }
end
repeat(3) { |i| puts "step #{i}" }
```

**`until` — the opposite of `while`:**

```ruby
done = false
count = 0
until done
  count += 1
  done = true if count >= 5
end
puts count   # => 5
```

---

## 6) Real-World Application

> *"How would you use this at work?"*

- **`times`** — retry logic: `3.times { attempt_request rescue nil }`
- **`each`** — process every record from a database query result
- **`reduce`** — total up order line items, build a config hash from an array
- **`each_with_object`** — index records by ID, group rows by category
- **`yield`** — every Ruby block-accepting method (`File.open`, `ActiveRecord::Base.transaction`, custom DSLs) uses yield internally

```ruby
# Real-world: group orders by status using each_with_object
orders = [
  { id: 1, status: :paid,    total: 50.0 },
  { id: 2, status: :pending, total: 30.0 },
  { id: 3, status: :paid,    total: 20.0 },
]

by_status = orders.each_with_object(Hash.new { |h, k| h[k] = [] }) do |order, groups|
  groups[order[:status]] << order
end

puts by_status[:paid].map { |o| o[:total] }.reduce(:+)   # => 70.0
```

---

## 7) Checklist

Before moving on, confirm you can:

- [ ] Use `n.times`, `n.upto(m)`, and `n.downto(m)` with a block
- [ ] Write a `while` loop and explain when it stops
- [ ] Write an `until` loop and explain how it differs from `while`
- [ ] Use `each` to iterate an Array and accumulate a result manually
- [ ] Use `reduce`/`inject` with an initial value and a block
- [ ] Use `reduce`/`inject` with a symbol shorthand (`:+`, `:*`)
- [ ] Use `each_with_object` to build a Hash or Array while iterating
- [ ] Use `yield` inside a method to call a caller-supplied block
- [ ] Use `block_given?` to make the block optional
- [ ] Explain the difference between `do…end` and `{ }` (convention: multiline vs one-liner)

---

## 8) Common Mistakes

| Mistake | Fix |
|---------|-----|
| `5.times { puts "hi" }` — forgetting the block variable | Add `\|i\|` if you need the index; it's optional if you don't |
| Infinite `while` loop (forgetting to advance the counter) | Always mutate the condition variable inside the loop |
| `reduce` without an initial value on an empty array | Pass `0` or `[]` as the first argument: `[].reduce(0, :+)` |
| Using `each_with_object` but forgetting to return the object | The block's last expression is NOT the return value — `each_with_object` returns the object you pass in |
| `yield` raises `LocalJumpError` when no block given | Guard with `yield if block_given?` |
| Confusing `downto` direction — `1.downto(5)` yields nothing | Put bigger number first: `5.downto(1)` |

---

## 9) Debug Flow

```
Loop runs forever?
  └─ Check that the condition variable changes inside the loop
  └─ Add a puts to print the variable each iteration
  └─ Consider using Ctrl+C to break out, then fix the logic

reduce gives wrong answer?
  └─ Check the initial accumulator value (second arg or first element)
  └─ Print acc and n inside the block to trace each step
  └─ Ensure the block returns the NEW accumulator (last expression)

each_with_object hash is empty?
  └─ Make sure you're mutating `obj` (the second block param), not reassigning it
  └─ Confirm you're using `obj[key] = value`, not `obj = something`

yield: no block given (LocalJumpError)?
  └─ Add `if block_given?` guard after yield
  └─ Or ensure the caller is passing a block { } or do...end

downto / upto produces no output?
  └─ Check the direction: receiver.downto(lower), receiver.upto(upper)
  └─ If receiver == limit, you still get exactly one iteration
```

---

## 10) Stretch Goal

Build a **lazy number generator** using `yield`:

```ruby
def fibonacci_up_to(limit)
  a, b = 0, 1
  while a <= limit
    yield a
    a, b = b, a + b
  end
end

fibs = []
fibonacci_up_to(100) { |n| fibs << n }
puts fibs.inspect
# => [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]

# Use reduce to sum all even fibonacci numbers up to 100
even_sum = fibs.select(&:even?).reduce(0, :+)
puts even_sum   # => 44
```

Extend it: use `each_with_object` to build a Hash `{ index => fib_value }`.
