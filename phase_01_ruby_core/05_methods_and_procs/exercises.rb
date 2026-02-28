# frozen_string_literal: true

# ============================================================
# Lesson 05 — Methods, Procs, and Lambdas
# exercises.rb — Guided exercises with hints
# ============================================================
# Complete each exercise. The test_lesson.rb file will verify
# your solutions automatically.
# Run tests with:  bundle exec rspec test_lesson.rb
# ============================================================

# ------------------------------------------------------------
# Exercise 1: Method with keyword arguments
# ------------------------------------------------------------
# Write a method `format_name` that takes:
#   - first_name (positional, required)
#   - last_name (positional, required)
#   - style: (keyword, optional, default: :full)
#
# When style is :full   => return "First Last"
# When style is :last   => return "Last, First"
# When style is :initials => return "F.L."
#
# Hint: Use a case statement on the style parameter
# Hint: String#chars.first or String#[0] gets the first character
#
# Example:
#   format_name("John", "Doe")                  # => "John Doe"
#   format_name("John", "Doe", style: :last)    # => "Doe, John"
#   format_name("John", "Doe", style: :initials)# => "J.D."

def format_name(first_name, last_name, style: :full)
  # TODO: implement using a case statement
  # Hint: case style
  #       when :full     then ...
  #       when :last     then ...
  #       when :initials then ...
  #       end
end

# ------------------------------------------------------------
# Exercise 2: Splat arguments
# ------------------------------------------------------------
# Write a method `stats` that accepts any number of numbers
# and returns a Hash with keys:
#   :count, :sum, :min, :max, :average
#
# Hint: Use *numbers as the parameter
# Hint: Array has .sum, .min, .max, .count
# Hint: average = sum / count.to_f

def stats(*numbers)
  # TODO: return a hash with :count, :sum, :min, :max, :average
  # Hint: {
  #   count:   numbers.count,
  #   sum:     numbers.sum,
  #   min:     numbers.min,
  #   max:     numbers.max,
  #   average: numbers.sum / numbers.count.to_f
  # }
end

# ------------------------------------------------------------
# Exercise 3: Proc that filters
# ------------------------------------------------------------
# Create a Proc called `long_word` that returns true if
# the given string has more than 5 characters.
#
# Hint: Use .length or .size
# Hint: Proc.new { |word| ... }

long_word = Proc.new do |word|
  # TODO: return true if word.length > 5
end

# ------------------------------------------------------------
# Exercise 4: Lambda for safe math
# ------------------------------------------------------------
# Create a lambda called `safe_sqrt` that:
# - Returns the square root of a number if it's >= 0
# - Returns nil if the number is negative
#
# Hint: Math.sqrt(n) computes the square root
# Hint: Use a ternary: condition ? value_if_true : value_if_false

safe_sqrt = lambda do |n|
  # TODO: return nil if n < 0, otherwise return Math.sqrt(n)
end

# ------------------------------------------------------------
# Exercise 5: Yield with accumulation
# ------------------------------------------------------------
# Write a method `collect_results(n)` that yields the numbers
# 1 through n to a block and collects the block's return
# values into an Array, which it returns.
#
# Hint: Use (1..n).map { |i| yield(i) }
# OR:
# Hint: results = []
#       1.upto(n) { |i| results << yield(i) }
#       results

def collect_results(n)
  # TODO: yield 1..n and collect results
end

# ------------------------------------------------------------
# Exercise 6: Method object with map
# ------------------------------------------------------------
# Define a method `word_length(str)` that returns str.length
#
# Then use method(:word_length) and map to transform this list:
#   ["cat", "elephant", "ox"]
# into their lengths: [3, 8, 2]
#
# Store the result in `lengths`
#
# Hint: lengths = ["cat", "elephant", "ox"].map(&method(:word_length))

def word_length(str)
  # TODO: return the length of str
end

lengths = nil # TODO: replace nil with your map call

# ------------------------------------------------------------
# Exercise 7: Closure counter
# ------------------------------------------------------------
# Write a method `make_adder(n)` that returns a lambda.
# The lambda, when called with a number x, returns x + n.
# (n is "closed over" from the outer method)
#
# Hint: def make_adder(n)
#         lambda { |x| x + n }
#       end

def make_adder(n)
  # TODO: return a lambda that adds n to its argument
end

add_five = make_adder(5)
add_ten  = make_adder(10)

# add_five.call(3)  # => 8
# add_ten.call(3)   # => 13
