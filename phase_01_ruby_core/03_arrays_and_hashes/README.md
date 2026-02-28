# Lesson 03 — Arrays and Hashes

---

## 1) Concept Overview

Arrays are ordered, integer-indexed lists of any objects.
Hashes are unordered key-value stores — keys are usually Symbols.
Both are Ruby's workhorse data structures, used in almost every program.
`map/select/reject/find` transform or query collections without manual loops.
`Hash.new(0)` auto-initialises missing keys to `0`, perfect for counting.

---

## 2) Mental Model Diagram

```
ARRAY                              HASH
─────────────────────────          ──────────────────────────────
fruits = ["apple","banana","cherry"]
                                   person = { name: "Alice", age: 30 }
index:   0        1        2
                                   key    value
fruits[0]  => "apple"              :name  "Alice"
fruits[-1] => "cherry"             :age   30
fruits[1..2] => ["banana","cherry"]

STACK / QUEUE operations:
  push  → add to end      pop   → remove from end
  unshift → add to front  shift → remove from front

  [1,2,3].push(4)    => [1,2,3,4]
  [1,2,3].pop        => 3, array is now [1,2]
  [1,2,3].unshift(0) => [0,1,2,3]
  [1,2,3].shift      => 1, array is now [2,3]

FUNCTIONAL TRANSFORMS:
  map    — transform every element, return new array
  select — keep elements where block is true
  reject — drop elements where block is true
  find   — return FIRST element where block is true (or nil)

ARRAY OF HASHES (common real-world pattern):
  users = [
    { name: "Alice", age: 30 },
    { name: "Bob",   age: 25 }
  ]
  users.map { |u| u[:name] }    => ["Alice", "Bob"]
  users.select { |u| u[:age] > 27 } => [{ name: "Alice", age: 30 }]

HASH.NEW(0) — counting pattern:
  counts = Hash.new(0)
  ["a","b","a"].each { |x| counts[x] += 1 }
  counts  => {"a"=>2, "b"=>1}
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# Array creation
fruits = ["apple", "banana", "cherry"]
nums   = Array.new(3, 0)   # => [0, 0, 0]

# Access
puts fruits[0]     # => "apple"
puts fruits[-1]    # => "cherry"
puts fruits[1..2].inspect  # => ["banana", "cherry"]

# push / pop / shift / unshift
fruits.push("date")       # add to end
last = fruits.pop         # remove from end => "date"
fruits.unshift("avocado") # add to front
first = fruits.shift      # remove from front => "avocado"

# map / select / reject / find
doubled = [1, 2, 3, 4].map    { |n| n * 2 }
evens   = [1, 2, 3, 4].select { |n| n.even? }
odds    = [1, 2, 3, 4].reject { |n| n.even? }
found   = [1, 2, 3, 4].find   { |n| n > 2 }

# Hash creation and access
person = { name: "Alice", age: 30, role: "developer" }
puts person[:name]          # => "Alice"
person[:email] = "a@b.com"  # add new key

# Hash iteration
person.each { |key, val| puts "#{key}: #{val}" }

# Hash.new(0) counting pattern
counts = Hash.new(0)
["ruby", "python", "ruby", "go"].each { |lang| counts[lang] += 1 }
puts counts.inspect  # => {"ruby"=>2, "python"=>1, "go"=>1}
```

---

## 4) You Type This

Open `starter.rb` and complete the TODOs. Then try:

1. Build an array of 5 numbers and use `push`/`pop`/`shift`/`unshift` to rearrange it.
2. Use `map` to square every number in `[1, 2, 3, 4, 5]`.
3. Use `select` to find words longer than 4 letters in `["hi", "hello", "world", "ox"]`.
4. Create a hash `{ ruby: 1995, python: 1991, go: 2009 }` and iterate it with `each`.
5. Use `Hash.new(0)` to count how many times each letter appears in `"mississippi"`.

---

## 5) Expand the Example

**Chaining functional methods:**

```ruby
# Find the names of users older than 25, sorted alphabetically
users = [
  { name: "Charlie", age: 22 },
  { name: "Alice",   age: 30 },
  { name: "Bob",     age: 28 }
]

result = users
  .select { |u| u[:age] > 25 }
  .map    { |u| u[:name] }
  .sort

puts result.inspect   # => ["Alice", "Bob"]
```

**Useful Hash methods:**

```ruby
h = { a: 1, b: 2, c: 3 }
h.keys          # => [:a, :b, :c]
h.values        # => [1, 2, 3]
h.any?  { |_, v| v > 2 }   # => true
h.all?  { |_, v| v > 0 }   # => true
h.count { |_, v| v.odd? }  # => 2
h.select { |_, v| v > 1 }  # => { b: 2, c: 3 }
h.map    { |k, v| [k, v * 10] }.to_h  # => { a: 10, b: 20, c: 30 }
h.min_by { |_, v| v }       # => [:a, 1]
```

---

## 6) Real-World Application

> *"How would you use this at work?"*

- **Array of hashes** — every API response is an array of JSON objects (hashes in Ruby).
- **`map`** — extract one field from every record: `orders.map { |o| o[:total] }`.
- **`select`/`reject`** — filter records by status, role, or any predicate.
- **`find`** — look up a record by ID without a database: `users.find { |u| u[:id] == 42 }`.
- **`Hash.new(0)`** — word frequency, vote tallying, inventory counts.

```ruby
# Real-world: summarise an order list
orders = [
  { product: "widget", qty: 3, price: 9.99 },
  { product: "gadget", qty: 1, price: 49.99 },
  { product: "widget", qty: 2, price: 9.99 }
]

totals = Hash.new(0.0)
orders.each { |o| totals[o[:product]] += o[:qty] * o[:price] }
puts totals.inspect   # => {"widget"=>49.95, "gadget"=>49.99}
```

---

## 7) Checklist

Before moving on, confirm you can:

- [ ] Create an array literal and with `Array.new`
- [ ] Access elements by positive and negative index, and with ranges
- [ ] Use `push`, `pop`, `shift`, and `unshift` and know which end each touches
- [ ] Use `map` to transform every element into something new
- [ ] Use `select` and `reject` to filter elements by a condition
- [ ] Use `find` to retrieve the first matching element (returns one item, not an array)
- [ ] Create a hash with symbol keys and access/add/update values
- [ ] Iterate a hash with `each` and unpack `|key, value|`
- [ ] Use `Hash.new(0)` to count occurrences without `nil` errors
- [ ] Chain `select` + `map` + `sort` on an array of hashes

---

## 8) Common Mistakes

| Mistake | Fix |
|---------|-----|
| `arr[arr.length]` to get the last element | Use `arr[-1]` or `arr.last` |
| `find` returning an Array | `find` returns one element (or nil); `select` returns an array |
| Modifying an array while iterating it | Iterate a copy with `.dup`, or use `map`/`select` which create new arrays |
| `hash["key"]` when keys are symbols | Use `hash[:key]` — `"key"` and `:key` are different objects |
| `Hash.new(0)` vs `{}` | `{}[:missing]` gives `nil` (crashes on `+= 1`); `Hash.new(0)[:missing]` gives `0` |
| `map` returns new array but result is discarded | Always assign: `result = arr.map { ... }` |
| `pop`/`shift` mutate the original array | If you need the original intact, use `arr.last`/`arr.first` to read without removing |

---

## 9) Debug Flow

```
NoMethodError: undefined method '+' for nil?
  └─ You're using {} instead of Hash.new(0) for counting
  └─ Fix: counts = Hash.new(0); then counts[key] += 1 is safe

find returned nil unexpectedly?
  └─ puts arr.inspect  — check what's actually in the array
  └─ Test your block alone: arr.map { |x| x[:key] }
  └─ Check for symbol vs string key mismatch: :name vs "name"

Array index off by one?
  └─ Remember: arrays are 0-indexed
  └─ Use arr.first / arr.last for clarity at the edges
  └─ Negative index: arr[-1] is last, arr[-2] is second-to-last

select/reject returns empty array?
  └─ puts arr.map { |x| [x, block_condition(x)] }.inspect
  └─ Verify the condition is actually true for some elements

map returns array of nils?
  └─ The block's last expression is nil — check the block returns a value
  └─ Common culprit: puts inside map (puts returns nil)
```

---

## 10) Stretch Goal

Build a **mini group-by aggregator**:

```ruby
# Group an array of hashes by a field and compute per-group statistics
orders = [
  { region: "north", amount: 100 },
  { region: "south", amount:  80 },
  { region: "north", amount: 150 },
  { region: "south", amount: 200 },
  { region: "east",  amount:  60 }
]

# Group totals by region using Hash.new(0)
region_totals = Hash.new(0)
orders.each { |o| region_totals[o[:region]] += o[:amount] }

# Find the top region
top = region_totals.max_by { |_, total| total }
puts "Top region: #{top[0]} with $#{top[1]}"
# => Top region: south with $280

# Sort all regions by total descending
region_totals.sort_by { |_, total| -total }.each do |region, total|
  puts "  #{region}: $#{total}"
end
# =>   south: $280
# =>   north: $250
# =>   east:  $60
```

Extend it: also compute the average order amount per region.
