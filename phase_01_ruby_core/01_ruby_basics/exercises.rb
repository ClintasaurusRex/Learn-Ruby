# frozen_string_literal: true

# ============================================================
# Lesson 01 — Ruby Basics
# exercises.rb — Guided exercises with hints
# ============================================================
# Complete each exercise. The test_lesson.rb file will verify
# your solutions automatically.
# Run tests with:  bundle exec rspec test_lesson.rb
# ============================================================

# ------------------------------------------------------------
# Exercise 1: Identify data types
# ------------------------------------------------------------
# Write a method `data_type_of(val)` that returns the class
# name of the given value as a String.
#
# Examples:
#   data_type_of("hello")  # => "String"
#   data_type_of(42)       # => "Integer"
#   data_type_of(3.14)     # => "Float"
#   data_type_of(true)     # => "TrueClass"
#   data_type_of(nil)      # => "NilClass"
#   data_type_of(:foo)     # => "Symbol"
#
# Hint: Every Ruby object has a .class method
# Hint: .class returns a Class object; call .name on it to get the String
# Hint: val.class.name gives you "String", "Integer", etc.

def data_type_of(val)
  # TODO: return the class name of val as a String
  # Hint: val.class.name
end

# ------------------------------------------------------------
# Exercise 2: Arithmetic operations
# ------------------------------------------------------------
# Write a method `arithmetic(a, b)` that returns a Hash
# containing the results of all 6 arithmetic operations on a and b.
#
# The Hash must have these exact keys:
#   :sum        => a + b
#   :difference => a - b
#   :product    => a * b
#   :quotient   => a.to_f / b   (Float division, NOT integer division)
#   :modulo     => a % b
#   :power      => a ** b
#
# Example:
#   arithmetic(10, 3)
#   # => { sum: 13, difference: 7, product: 30,
#   #      quotient: 3.3333..., modulo: 1, power: 1000 }
#
# Hint: Use a Hash literal with symbol keys
# Hint: For :quotient use a.to_f / b so the result is a Float

def arithmetic(a, b)
  # TODO: return a Hash with the 6 arithmetic results
  # Hint: {
  #   sum:        a + b,
  #   difference: a - b,
  #   product:    a * b,
  #   quotient:   a.to_f / b,
  #   modulo:     a % b,
  #   power:      a ** b
  # }
end

# ------------------------------------------------------------
# Exercise 3: Comparison operators
# ------------------------------------------------------------
# Write a method `compare(a, b)` that returns a Hash with
# the results of three comparisons:
#
#   :equal   => a == b
#   :greater => a > b
#   :less    => a < b
#
# Example:
#   compare(10, 20)  # => { equal: false, greater: false, less: true }
#   compare(5, 5)    # => { equal: true,  greater: false, less: false }
#
# Hint: Each value in the Hash should be a boolean (true or false)

def compare(a, b)
  # TODO: return a Hash with :equal, :greater, :less
  # Hint: {
  #   equal:   a == b,
  #   greater: a > b,
  #   less:    a < b
  # }
end

# ------------------------------------------------------------
# Exercise 4: Type conversion — to Integer
# ------------------------------------------------------------
# Write a method `convert_to_int(val)` that converts val to
# an Integer using Ruby's built-in conversion method.
#
# Examples:
#   convert_to_int("42")   # => 42
#   convert_to_int(3.9)    # => 3    (truncates, does NOT round)
#   convert_to_int(nil)    # => 0
#   convert_to_int("7px")  # => 7    (stops at first non-digit)
#
# Hint: Use .to_i on the value

def convert_to_int(val)
  # TODO: return val converted to an Integer
  # Hint: val.to_i
end

# ------------------------------------------------------------
# Exercise 5: Type conversion — to String
# ------------------------------------------------------------
# Write a method `convert_to_string(val)` that converts val to
# a String using Ruby's built-in conversion method.
#
# Examples:
#   convert_to_string(42)     # => "42"
#   convert_to_string(3.14)   # => "3.14"
#   convert_to_string(true)   # => "true"
#   convert_to_string(nil)    # => ""
#   convert_to_string(:hello) # => "hello"
#
# Hint: Use .to_s on the value

def convert_to_string(val)
  # TODO: return val converted to a String
  # Hint: val.to_s
end

# ============================================================
# Bonus exploration (not tested — just try it out)
# ============================================================

# What is the class of each literal?
# puts 42.class          # => Integer
# puts 3.14.class        # => Float
# puts "hi".class        # => String
# puts true.class        # => TrueClass
# puts nil.class         # => NilClass
# puts :symbol.class     # => Symbol

# Integer division gotcha:
# puts 7 / 2             # => 3   (not 3.5!)
# puts 7.to_f / 2        # => 3.5

# Chained conversions:
# puts "  99.9  ".strip.to_f.round   # => 100
