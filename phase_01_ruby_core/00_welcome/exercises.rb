# frozen_string_literal: true

# ============================================================
# Lesson 00 — Welcome to Ruby
# exercises.rb — Guided exercises with hints
# ============================================================
# Complete each exercise. The test_lesson.rb file will verify
# your solutions automatically.
# Run tests with:  bundle exec rspec test_lesson.rb
# ============================================================

# ------------------------------------------------------------
# Exercise 1: output_demo
# ------------------------------------------------------------
# Write a method `output_demo` that returns the String:
#   "puts prints a newline, p shows inspect, print has no newline"
#
# The method takes no arguments and returns that exact String.
#
# Hint: def output_demo
#         "puts prints a newline, p shows inspect, print has no newline"
#       end

def output_demo
  # TODO: return the string describing puts/p/print differences
  # Hint: just return the exact string shown above
end

# ------------------------------------------------------------
# Exercise 2: interpolate_name
# ------------------------------------------------------------
# Write a method `interpolate_name(name, age)` that accepts a
# name (String) and an age (Integer) and returns a String using
# string interpolation in this exact format:
#   "My name is Alice and I am 30 years old."
#
# Hint: Use #{name} and #{age} inside a double-quoted string
# Hint: Don't forget the period at the end

def interpolate_name(name, age)
  # TODO: return an interpolated string with name and age
  # Hint: "My name is #{name} and I am #{age} years old."
end

# ------------------------------------------------------------
# Exercise 3: add_comment
# ------------------------------------------------------------
# Write a method `add_comment(str)` that takes a String and
# returns it unchanged. The point is to prove that comments
# inside a method don't affect the return value.
#
# Inside the method body, add at least one comment line that
# says something (e.g., "# returning the string unchanged")
# — then return str.
#
# Hint: def add_comment(str)
#         # this comment is ignored by Ruby
#         str
#       end

def add_comment(str)
  # TODO: add a comment here, then return str
  # Hint: the comment does nothing; just return str
end

# ------------------------------------------------------------
# Exercise 4: multi_line_output
# ------------------------------------------------------------
# Write a method `multi_line_output` that takes no arguments
# and returns an Array of exactly 3 Strings:
#   ["Line 1", "Line 2", "Line 3"]
#
# Hint: return an Array literal with the three strings
# Hint: def multi_line_output
#         ["Line 1", "Line 2", "Line 3"]
#       end

def multi_line_output
  # TODO: return an Array of 3 strings: ["Line 1", "Line 2", "Line 3"]
end

# ------------------------------------------------------------
# Exercise 5: inspect_value
# ------------------------------------------------------------
# Write a method `inspect_value(val)` that takes any Ruby object
# and returns val.inspect as a String.
#
# This mirrors what `p` does under the hood — `p x` is roughly
# equivalent to `puts x.inspect`.
#
# Examples:
#   inspect_value("hello")   # => "\"hello\""
#   inspect_value(42)        # => "42"
#   inspect_value([1, 2, 3]) # => "[1, 2, 3]"
#   inspect_value(nil)       # => "nil"
#
# Hint: def inspect_value(val)
#         val.inspect
#       end

def inspect_value(val)
  # TODO: return val.inspect
end
