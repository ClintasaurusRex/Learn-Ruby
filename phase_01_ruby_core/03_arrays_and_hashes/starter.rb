# frozen_string_literal: true

# ============================================================
# Lesson 03 — Arrays and Hashes
# starter.rb — Working starter code with TODOs and Hints
# ============================================================
# Run this file with:  ruby starter.rb
# ============================================================

# ------------------------------------------------------------
# PART 1: Array Creation and Access
# ------------------------------------------------------------

# This already works — study it, then modify it below
fruits = ["apple", "banana", "cherry", "date"]

puts fruits[0]      # => apple
puts fruits[-1]     # => date
puts fruits[1..2].inspect  # => ["banana", "cherry"]

# Array.new with a default value — already works
zeros = Array.new(4, 0)
puts zeros.inspect  # => [0, 0, 0, 0]

# TODO: Create an array called `numbers` containing integers 1 through 5
# Hint: You can write the literal [1, 2, 3, 4, 5]
#       OR use the range shortcut:  (1..5).to_a
numbers = nil # TODO: replace with your array

# TODO: Print the third element of `numbers` (index 2)
# Hint: numbers[2]
# puts numbers[2]

# TODO: Print a slice of numbers from index 1 to 3 (inclusive)
# Hint: numbers[1..3]  or  numbers[1, 3]  (start, length)
# puts numbers[1..3].inspect

# ------------------------------------------------------------
# PART 2: push / pop / shift / unshift
# ------------------------------------------------------------

puts "\n--- PART 2: push/pop/shift/unshift ---"

# Study this working example
queue = ["b", "c", "d"]
queue.unshift("a")   # add to front
queue.push("e")      # add to end
puts queue.inspect   # => ["a", "b", "c", "d", "e"]

removed_front = queue.shift  # remove from front
removed_back  = queue.pop    # remove from end
puts removed_front   # => a
puts removed_back    # => e
puts queue.inspect   # => ["b", "c", "d"]

# TODO: Start with stack = [10, 20, 30]
#       push 40 onto it, then pop twice and print the popped values
# Hint: val = stack.pop   returns the removed element
stack = [10, 20, 30]
# TODO: stack.push(...)
# TODO: val1 = stack.pop;  puts val1
# TODO: val2 = stack.pop;  puts val2
# puts stack.inspect  # should show [10, 20]

# ------------------------------------------------------------
# PART 3: map / select / reject / find
# ------------------------------------------------------------

puts "\n--- PART 3: map/select/reject/find ---"

# Study these working examples
nums = [1, 2, 3, 4, 5, 6]

doubled   = nums.map    { |n| n * 2 }
evens     = nums.select { |n| n.even? }
odds      = nums.reject { |n| n.even? }
first_big = nums.find   { |n| n > 4 }

puts doubled.inspect    # => [2, 4, 6, 8, 10, 12]
puts evens.inspect      # => [2, 4, 6]
puts odds.inspect       # => [1, 3, 5]
puts first_big          # => 5

# TODO: Given words = ["ruby", "python", "go", "elixir", "java"]
#       Use map to create an array of each word's length
# Hint: words.map { |w| w.length }
words = ["ruby", "python", "go", "elixir", "java"]
# lengths = words.map { ... }
# puts lengths.inspect  # => [4, 6, 2, 6, 4]

# TODO: Use select to keep only words longer than 4 characters
# Hint: words.select { |w| w.length > 4 }
# long_words = words.select { ... }
# puts long_words.inspect  # => ["python", "elixir"]

# TODO: Use find to get the first word that starts with "e"
# Hint: w.start_with?("e")  or  w[0] == "e"
# first_e = words.find { ... }
# puts first_e   # => "elixir"

# ------------------------------------------------------------
# PART 4: Array of Hashes
# ------------------------------------------------------------

puts "\n--- PART 4: Array of Hashes ---"

# Study this working example
users = [
  { name: "Alice", age: 30, admin: true  },
  { name: "Bob",   age: 22, admin: false },
  { name: "Carol", age: 35, admin: true  },
  { name: "Dave",  age: 19, admin: false }
]

# Extract all names
names = users.map { |u| u[:name] }
puts names.inspect   # => ["Alice", "Bob", "Carol", "Dave"]

# Find admins only
admins = users.select { |u| u[:admin] }
puts admins.map { |u| u[:name] }.inspect  # => ["Alice", "Carol"]

# TODO: Use find to get the first user whose age is under 21
# Hint: users.find { |u| u[:age] < 21 }
# young = users.find { ... }
# puts young[:name]   # => Dave

# TODO: Use map to build an array of strings like "Alice is 30"
# Hint: users.map { |u| "#{u[:name]} is #{u[:age]}" }
# descriptions = users.map { ... }
# puts descriptions.inspect

# ------------------------------------------------------------
# PART 5: Hash Creation and Iteration
# ------------------------------------------------------------

puts "\n--- PART 5: Hash creation and iteration ---"

# Study these working examples
config = { host: "localhost", port: 5432, ssl: true }
puts config[:host]     # => localhost
puts config[:port]     # => 5432

config[:timeout] = 30  # add a new key
puts config.inspect

# Iterate with each
config.each do |key, value|
  puts "  #{key} => #{value}"
end

# Useful hash methods
puts config.keys.inspect    # => [:host, :port, :ssl, :timeout]
puts config.values.inspect
puts config.key?(:ssl)      # => true
puts config.value?(9999)    # => false

# TODO: Create a hash `scores` mapping three names to numeric scores
# Hint: { alice: 95, bob: 87, carol: 91 }
# scores = { ... }

# TODO: Use each to print "alice scored 95", etc.
# Hint: scores.each { |name, score| puts "#{name} scored #{score}" }

# TODO: Use scores.max_by to find the highest scorer
# Hint: scores.max_by { |_, score| score }
# winner = scores.max_by { ... }
# puts "Winner: #{winner[0]}"

# ------------------------------------------------------------
# PART 6: Hash.new(0) — Counting Pattern
# ------------------------------------------------------------

puts "\n--- PART 6: Hash.new(0) ---"

# Study this working example
languages = ["ruby", "python", "ruby", "go", "python", "ruby"]
counts = Hash.new(0)
languages.each { |lang| counts[lang] += 1 }
puts counts.inspect   # => {"ruby"=>3, "python"=>2, "go"=>1}

# Find the most popular
most_popular = counts.max_by { |_, count| count }
puts "Most popular: #{most_popular[0]}"   # => Most popular: ruby

# TODO: Count how many times each character appears in "mississippi"
# Hint: "mississippi".chars gives you an array of characters
# Hint: Use Hash.new(0) and .each to count
# char_counts = Hash.new(0)
# "mississippi".chars.each { |c| char_counts[c] += 1 }
# puts char_counts.inspect
# => {"m"=>1, "i"=>4, "s"=>4, "p"=>2}

# ============================================================
# Run this file to see your output:  ruby starter.rb
# Uncomment the TODO lines one at a time and fill them in.
# ============================================================
