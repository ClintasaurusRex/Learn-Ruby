# frozen_string_literal: true

# ============================================================
# Lesson 00 — Welcome to Ruby
# solutions.rb — Solutions with plain-language explanations
# ============================================================

# ------------------------------------------------------------
# Exercise 1: output_demo
# ------------------------------------------------------------
# The method simply returns a descriptive String — no logic needed.
# This confirms you know how to define a method and return a String.
# Ruby methods automatically return the value of the last expression,
# so you don't need an explicit `return` keyword here.

def output_demo
  "puts prints a newline, p shows inspect, print has no newline"
end

puts output_demo
# => puts prints a newline, p shows inspect, print has no newline

# ------------------------------------------------------------
# Exercise 2: interpolate_name
# ------------------------------------------------------------
# String interpolation uses #{} inside double-quoted strings.
# Any Ruby expression placed inside #{} is evaluated and its
# string representation is inserted into the surrounding string.
# Single-quoted strings do NOT interpolate — always use " for this.

def interpolate_name(name, age)
  "My name is #{name} and I am #{age} years old."
end

puts interpolate_name("Alice", 30)
# => My name is Alice and I am 30 years old.

puts interpolate_name("Bob", 25)
# => My name is Bob and I am 25 years old.

# ------------------------------------------------------------
# Exercise 3: add_comment
# ------------------------------------------------------------
# Comments (lines starting with # or text after an inline #) are
# completely ignored by the Ruby interpreter — they produce no output
# and do not affect any values.  This method demonstrates that a
# comment inside a method body has zero impact on what the method returns.

def add_comment(str)
  # returning the string unchanged — comments don't alter the value
  str
end

puts add_comment("hello")          # => hello
puts add_comment("test string")    # => test string
p add_comment("unchanged")         # => "unchanged"

# ------------------------------------------------------------
# Exercise 4: multi_line_output
# ------------------------------------------------------------
# We return an Array literal containing three strings.
# puts called on an Array prints each element on a separate line.
# p called on an Array shows the full bracket notation on one line.
# By returning an Array from the method, callers can choose how to display it.

def multi_line_output
  ["Line 1", "Line 2", "Line 3"]
end

puts "--- puts ---"
puts multi_line_output
# Line 1
# Line 2
# Line 3

puts "--- p ---"
p multi_line_output
# => ["Line 1", "Line 2", "Line 3"]

# ------------------------------------------------------------
# Exercise 5: inspect_value
# ------------------------------------------------------------
# Every Ruby object has an `.inspect` method that returns a
# developer-friendly String representation — the same thing `p` prints.
# Strings show their quotes; nil shows "nil"; arrays show brackets.
# This is the most reliable way to see EXACTLY what a value is,
# not just how it would be displayed to a user.

def inspect_value(val)
  val.inspect
end

puts inspect_value("hello")    # => "hello"
puts inspect_value(42)         # => 42
puts inspect_value([1, 2, 3])  # => [1, 2, 3]
puts inspect_value(nil)        # => nil
puts inspect_value(true)       # => true
