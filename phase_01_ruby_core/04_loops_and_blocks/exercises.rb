# frozen_string_literal: true

# ============================================================
# Lesson 04 — Loops and Blocks
# exercises.rb — Guided exercises with hints
# ============================================================
# Complete each exercise. The test_lesson.rb file will verify
# your solutions automatically.
# Run tests with:  bundle exec rspec test_lesson.rb
# ============================================================

# ------------------------------------------------------------
# Exercise 1: countdown(n) — downto
# ------------------------------------------------------------
# Write a method `countdown(n)` that returns an Array of integers
# counting from n down to 1 (using downto).
#
# Example:
#   countdown(5)  # => [5, 4, 3, 2, 1]
#   countdown(3)  # => [3, 2, 1]
#   countdown(1)  # => [1]
#
# Hint: Start with an empty array: result = []
# Hint: Use n.downto(1) { |i| result << i }
# Hint: Return result at the end

def countdown(n)
  # TODO: use downto to build and return an Array from n down to 1
  # Hint: result = []
  #       n.downto(1) { |i| result << i }
  #       result
end

# ------------------------------------------------------------
# Exercise 2: factorial(n) — reduce / inject
# ------------------------------------------------------------
# Write a method `factorial(n)` that computes n! (n factorial)
# using reduce or inject.
#
# factorial(0) => 1  (by convention, 0! = 1)
# factorial(1) => 1
# factorial(5) => 120   (5 * 4 * 3 * 2 * 1)
# factorial(6) => 720
#
# Hint: For n >= 1, use (1..n).reduce(:*)
# Hint: For n == 0, return 1 directly (edge case)
# Hint: You can combine with a ternary: n == 0 ? 1 : (1..n).reduce(:*)

def factorial(n)
  # TODO: return n! using reduce or inject
  # Hint: return 1 if n == 0
  # Hint: (1..n).reduce(:*)
end

# ------------------------------------------------------------
# Exercise 3: sum_with_each(arr) — each accumulation
# ------------------------------------------------------------
# Write a method `sum_with_each(arr)` that iterates the array
# using each and accumulates the total manually.
# Do NOT use .sum, .reduce, or .inject.
# Return the total as an Integer (or Float if the input has floats).
#
# Example:
#   sum_with_each([1, 2, 3, 4])   # => 10
#   sum_with_each([10, 20, 30])   # => 60
#   sum_with_each([])             # => 0
#
# Hint: Start with total = 0
# Hint: arr.each { |n| total += n }
# Hint: Return total

def sum_with_each(arr)
  # TODO: iterate arr with each, accumulate total, return total
  # Hint: total = 0
  #       arr.each { |n| total += n }
  #       total
end

# ------------------------------------------------------------
# Exercise 4: group_by_length(arr) — each_with_object
# ------------------------------------------------------------
# Write a method `group_by_length(arr)` that takes an Array of
# Strings and returns a Hash where:
#   key   = word length (Integer)
#   value = Array of words with that length
#
# Use each_with_object to build the result Hash.
#
# Example:
#   group_by_length(["cat", "ox", "bee", "ant"])
#   # => {3=>["cat", "bee", "ant"], 2=>["ox"]}
#
# Hint: arr.each_with_object({}) do |word, h|
#         h[word.length] ||= []
#         h[word.length] << word
#       end

def group_by_length(arr)
  # TODO: use each_with_object to build and return a Hash
  # Hint: arr.each_with_object({}) do |word, h|
  #         h[word.length] ||= []
  #         h[word.length] << word
  #       end
end

# ------------------------------------------------------------
# Exercise 5: run_and_collect(n) — yield
# ------------------------------------------------------------
# Write a method `run_and_collect(n)` that yields the integers
# 1 through n to a caller-supplied block, and returns an Array
# of all the block's return values.
#
# Example:
#   run_and_collect(3) { |i| i * 2 }   # => [2, 4, 6]
#   run_and_collect(4) { |i| i ** 2 }  # => [1, 4, 9, 16]
#
# Hint: Use (1..n).map { |i| yield(i) }
# OR:
# Hint: results = []
#       1.upto(n) { |i| results << yield(i) }
#       results

def run_and_collect(n)
  # TODO: yield each integer 1..n and collect results
  # Hint: (1..n).map { |i| yield(i) }
end
