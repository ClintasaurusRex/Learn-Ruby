# frozen_string_literal: true

# ============================================================
# Lesson 03 — Arrays and Hashes
# exercises.rb — Guided exercises with hints
# ============================================================
# Complete each exercise. The test_lesson.rb file will verify
# your solutions automatically.
# Run tests with:  bundle exec rspec test_lesson.rb
# ============================================================

# ------------------------------------------------------------
# Exercise 1: double_all
# ------------------------------------------------------------
# Write a method `double_all` that takes an array of numbers
# and returns a NEW array where every element is doubled.
# Use `map`.
#
# Hint: arr.map { |n| n * 2 }
#
# Example:
#   double_all([1, 2, 3])   # => [2, 4, 6]
#   double_all([0, -5, 10]) # => [0, -10, 20]

def double_all(arr)
  # TODO: use map to return a new array with each element doubled
  # Hint: arr.map { |n| ... }
end

# ------------------------------------------------------------
# Exercise 2: select_evens
# ------------------------------------------------------------
# Write a method `select_evens` that takes an array of integers
# and returns a new array containing only the even numbers.
# Use `select`.
#
# Hint: n.even?  returns true if n is even
# Hint: arr.select { |n| ... }
#
# Example:
#   select_evens([1, 2, 3, 4, 5, 6]) # => [2, 4, 6]
#   select_evens([1, 3, 5])           # => []

def select_evens(arr)
  # TODO: use select to return only the even numbers
  # Hint: arr.select { |n| n.even? }
end

# ------------------------------------------------------------
# Exercise 3: first_long_word
# ------------------------------------------------------------
# Write a method `first_long_word` that takes an array of strings
# and returns the FIRST string whose length is greater than 5.
# If no string qualifies, return nil.
# Use `find`.
#
# Hint: str.length > 5
# Hint: arr.find { |str| ... }
#
# Example:
#   first_long_word(["hi", "hello", "elephant"])  # => "elephant"
#   first_long_word(["cat", "dog", "fox"])         # => nil

def first_long_word(arr)
  # TODO: use find to return the first string with length > 5
  # Hint: arr.find { |str| str.length > 5 }
end

# ------------------------------------------------------------
# Exercise 4: array_stats
# ------------------------------------------------------------
# Write a method `array_stats` that takes an array of numbers
# and returns a Hash with these keys:
#   :min     — the smallest number
#   :max     — the largest number
#   :sum     — the total
#   :count   — how many numbers there are
#   :average — the average as a Float
#
# Hint: Array has built-in .min, .max, .sum, .count methods
# Hint: average = sum / count.to_f   (.to_f avoids integer division)
#
# Example:
#   array_stats([1, 2, 3, 4, 5])
#   # => { min: 1, max: 5, sum: 15, count: 5, average: 3.0 }

def array_stats(arr)
  # TODO: return a hash with :min, :max, :sum, :count, :average
  # Hint: {
  #   min:     arr.min,
  #   max:     arr.max,
  #   sum:     arr.sum,
  #   count:   arr.count,
  #   average: arr.sum / arr.count.to_f
  # }
end

# ------------------------------------------------------------
# Exercise 5: count_occurrences
# ------------------------------------------------------------
# Write a method `count_occurrences` that takes an array of
# strings (or symbols) and returns a Hash where each unique
# element maps to the number of times it appears.
# Use the Hash.new(0) pattern.
#
# Hint: counts = Hash.new(0)
# Hint: arr.each { |item| counts[item] += 1 }
# Hint: Return counts at the end
#
# Example:
#   count_occurrences(["a", "b", "a", "c", "b", "a"])
#   # => {"a"=>3, "b"=>2, "c"=>1}

def count_occurrences(arr)
  # TODO: use Hash.new(0) to count each element
  # Hint: counts = Hash.new(0)
  #       arr.each { |item| counts[item] += 1 }
  #       counts
end

# ------------------------------------------------------------
# Exercise 6: extract_field
# ------------------------------------------------------------
# Write a method `extract_field` that takes:
#   - arr_of_hashes: an Array of Hashes
#   - key:           a Symbol
# and returns an Array of the values for that key from each hash.
# Use `map`.
#
# Hint: arr_of_hashes.map { |h| h[key] }
#
# Example:
#   users = [{ name: "Alice", age: 30 }, { name: "Bob", age: 25 }]
#   extract_field(users, :name)  # => ["Alice", "Bob"]
#   extract_field(users, :age)   # => [30, 25]

def extract_field(arr_of_hashes, key)
  # TODO: use map to pull the value at `key` from each hash
  # Hint: arr_of_hashes.map { |h| h[key] }
end
