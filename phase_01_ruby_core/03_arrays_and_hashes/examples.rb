# frozen_string_literal: true

# ============================================================
# Lesson 03 — Arrays and Hashes
# examples.rb — Complete runnable examples
# ============================================================
# Run with:  ruby examples.rb
# ============================================================

puts "=" * 60
puts "LESSON 03: Arrays and Hashes"
puts "=" * 60

# ------------------------------------------------------------
# 1. Array Creation and Access
# ------------------------------------------------------------
puts "\n--- 1. Array Creation and Access ---"

# Literal syntax
fruits = ["apple", "banana", "cherry", "date", "elderberry"]

# Positive and negative indexing
puts fruits[0]      # => apple
puts fruits[1]      # => banana
puts fruits[-1]     # => elderberry
puts fruits[-2]     # => date

# Range slice
puts fruits[1..3].inspect   # => ["banana", "cherry", "date"]
puts fruits[0, 2].inspect   # => ["apple", "banana"]  (start, length)

# Array.new
zeros    = Array.new(3, 0)         # => [0, 0, 0]
squares  = Array.new(5) { |i| (i + 1) ** 2 }  # => [1, 4, 9, 16, 25]
puts zeros.inspect    # => [0, 0, 0]
puts squares.inspect  # => [1, 4, 9, 16, 25]

# Range shortcut
puts (1..5).to_a.inspect   # => [1, 2, 3, 4, 5]
puts ('a'..'e').to_a.inspect  # => ["a", "b", "c", "d", "e"]

# Useful query methods
puts fruits.length          # => 5
puts fruits.include?("cherry")  # => true
puts fruits.empty?          # => false
puts fruits.first           # => apple
puts fruits.last            # => elderberry

# ------------------------------------------------------------
# 2. push / pop / shift / unshift
# ------------------------------------------------------------
puts "\n--- 2. push / pop / shift / unshift ---"

arr = [2, 3, 4]

arr.push(5)       # add to end  => [2, 3, 4, 5]
arr.unshift(1)    # add to front => [1, 2, 3, 4, 5]
puts arr.inspect  # => [1, 2, 3, 4, 5]

popped  = arr.pop    # remove from end   => 5, arr is [1, 2, 3, 4]
shifted = arr.shift  # remove from front => 1, arr is [2, 3, 4]
puts popped           # => 5
puts shifted          # => 1
puts arr.inspect      # => [2, 3, 4]

# Shovel operator << is an alias for push
arr << 5 << 6
puts arr.inspect  # => [2, 3, 4, 5, 6]

# Stack (LIFO) — push + pop
stack = []
stack.push("first")
stack.push("second")
stack.push("third")
puts stack.pop   # => third  (last in, first out)
puts stack.pop   # => second

# Queue (FIFO) — push + shift
queue = []
queue.push("first")
queue.push("second")
queue.push("third")
puts queue.shift  # => first  (first in, first out)
puts queue.shift  # => second

# ------------------------------------------------------------
# 3. map / select / reject / find
# ------------------------------------------------------------
puts "\n--- 3. map / select / reject / find ---"

numbers = [1, 2, 3, 4, 5, 6, 7, 8]

# map — transform every element, returns new array of same size
doubled    = numbers.map { |n| n * 2 }
as_strings = numbers.map { |n| "item_#{n}" }
puts doubled.inspect     # => [2, 4, 6, 8, 10, 12, 14, 16]
puts as_strings[0..2].inspect  # => ["item_1", "item_2", "item_3"]

# select — keep elements for which the block is true
evens      = numbers.select { |n| n.even? }
big        = numbers.select { |n| n > 5 }
puts evens.inspect  # => [2, 4, 6, 8]
puts big.inspect    # => [6, 7, 8]

# reject — drop elements for which the block is true (inverse of select)
odds       = numbers.reject { |n| n.even? }
small      = numbers.reject { |n| n > 5 }
puts odds.inspect   # => [1, 3, 5, 7]
puts small.inspect  # => [1, 2, 3, 4, 5]

# find (aka detect) — returns the FIRST matching element, or nil
first_even = numbers.find { |n| n.even? }
first_big  = numbers.find { |n| n > 10 }
puts first_even          # => 2
puts first_big.inspect   # => nil  (nothing matched)

# Chaining transforms
result = numbers
  .select { |n| n.odd? }
  .map    { |n| n ** 2 }
puts result.inspect   # => [1, 9, 25, 49]

# Symbol#to_proc shorthand
words = ["hello", "world", "ruby"]
puts words.map(&:upcase).inspect    # => ["HELLO", "WORLD", "RUBY"]
puts words.map(&:length).inspect    # => [5, 5, 4]

# ------------------------------------------------------------
# 4. Array of Hashes Pattern
# ------------------------------------------------------------
puts "\n--- 4. Array of Hashes ---"

products = [
  { name: "Laptop",  price: 999.00, stock: 5  },
  { name: "Mouse",   price:  29.99, stock: 50 },
  { name: "Monitor", price: 349.00, stock: 0  },
  { name: "Keyboard",price:  79.00, stock: 12 },
  { name: "Webcam",  price:  59.00, stock: 0  }
]

# Extract a single field from every record
names = products.map { |p| p[:name] }
puts names.inspect
# => ["Laptop", "Mouse", "Monitor", "Keyboard", "Webcam"]

# Filter by condition
in_stock = products.select { |p| p[:stock] > 0 }
puts in_stock.map { |p| p[:name] }.inspect
# => ["Laptop", "Mouse", "Keyboard"]

# Find one record
cheap = products.find { |p| p[:price] < 40 }
puts cheap[:name]   # => Mouse

# Sort by field
by_price = products.sort_by { |p| p[:price] }
puts by_price.map { |p| "#{p[:name]}: $#{p[:price]}" }.inspect
# => ["Mouse: $29.99", "Keyboard: $79.0", "Webcam: $59.0", ...]

# Compute a total
total_value = products.sum { |p| p[:price] * p[:stock] }
puts "Total inventory value: $#{total_value.round(2)}"
# => Total inventory value: $7391.5

# ------------------------------------------------------------
# 5. Hash Creation, Access, Iteration
# ------------------------------------------------------------
puts "\n--- 5. Hash Creation, Access, Iteration ---"

# Symbol-key hash (most common in Ruby)
config = {
  host:     "localhost",
  port:     5432,
  database: "myapp_development",
  pool:     5
}

# Access
puts config[:host]      # => localhost
puts config[:port]      # => 5432
puts config[:missing].inspect  # => nil  (no error, just nil)

# Add / update / delete
config[:timeout] = 30   # add
config[:pool]    = 10   # update
config.delete(:timeout) # remove
puts config.inspect

# Common hash methods
puts config.keys.inspect         # => [:host, :port, :database, :pool]
puts config.values.inspect       # => ["localhost", 5432, "myapp_development", 10]
puts config.key?(:host)          # => true
puts config.value?("localhost")  # => true
puts config.size                 # => 4

# Iteration
config.each { |key, val| puts "  #{key}: #{val}" }

# Transform values with map → to_h
upcased = { a: "hello", b: "world" }.transform_values(&:upcase)
puts upcased.inspect   # => {:a=>"HELLO", :b=>"WORLD"}

# Select/reject on hash (returns a hash)
big_keys = config.select { |_, v| v.is_a?(Integer) && v > 5 }
puts big_keys.inspect  # => {:port=>5432, :pool=>10}

# merge — combine hashes (right-side wins on conflict)
defaults = { timeout: 30, pool: 5, ssl: false }
overrides = { pool: 20, ssl: true }
merged = defaults.merge(overrides)
puts merged.inspect
# => {:timeout=>30, :pool=>20, :ssl=>true}

# ------------------------------------------------------------
# 6. Hash.new(0) — Counting Pattern
# ------------------------------------------------------------
puts "\n--- 6. Hash.new(0) counting pattern ---"

# Problem: count how many times each word appears
words_list = %w[apple banana apple cherry banana apple grape cherry]

# Using {} would crash on the first unknown key with += 1
# Hash.new(0) returns 0 for any missing key instead of nil
word_count = Hash.new(0)
words_list.each { |w| word_count[w] += 1 }
puts word_count.inspect
# => {"apple"=>3, "banana"=>2, "cherry"=>2, "grape"=>1}

# Sort by frequency descending
ranked = word_count.sort_by { |_, count| -count }
ranked.each { |word, count| puts "  #{word}: #{count}" }
# =>   apple: 3
# =>   banana: 2
# =>   cherry: 2
# =>   grape: 1

# Most frequent
top = word_count.max_by { |_, count| count }
puts "Most common: #{top[0]} (#{top[1]} times)"
# => Most common: apple (3 times)

# Character frequency
text = "mississippi"
char_freq = Hash.new(0)
text.chars.each { |c| char_freq[c] += 1 }
puts char_freq.sort.to_h.inspect
# => {"i"=>4, "m"=>1, "p"=>2, "s"=>4}

# Group-by-field count using Hash.new(0)
votes = ["ruby", "python", "ruby", "go", "python", "ruby", "go", "go"]
tally = Hash.new(0)
votes.each { |lang| tally[lang] += 1 }
winner = tally.max_by { |_, v| v }
puts "Winner: #{winner[0]}"   # => Winner: ruby

puts "\n" + "=" * 60
puts "All examples complete!"
puts "=" * 60
