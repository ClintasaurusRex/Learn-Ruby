# frozen_string_literal: true

# ============================================================
# Lesson 01 — Ruby Basics
# solutions.rb — Solutions with plain-language explanations
# ============================================================

# ------------------------------------------------------------
# Exercise 1: data_type_of
# ------------------------------------------------------------
# Every Ruby value is an object, and every object knows its class.
# Calling .class on any value returns the Class object (e.g., Integer).
# We then call .name on that Class object to get the plain String name
# like "Integer" or "NilClass". This works for ALL Ruby types with no
# special cases needed — Ruby handles it uniformly.

def data_type_of(val)
  val.class.name
end

puts data_type_of("hello")  # => String
puts data_type_of(42)       # => Integer
puts data_type_of(3.14)     # => Float
puts data_type_of(true)     # => TrueClass
puts data_type_of(nil)      # => NilClass
puts data_type_of(:foo)     # => Symbol

# ------------------------------------------------------------
# Exercise 2: arithmetic
# ------------------------------------------------------------
# We return a Hash so the caller can access each result by name
# rather than by position. Symbol keys (:sum, :difference, etc.)
# are conventional in Ruby because they're immutable and fast.
# The key detail for :quotient is using a.to_f / b — without .to_f,
# Ruby performs integer division (10 / 3 => 3), which loses precision.

def arithmetic(a, b)
  {
    sum:        a + b,
    difference: a - b,
    product:    a * b,
    quotient:   a.to_f / b,
    modulo:     a % b,
    power:      a ** b
  }
end

result = arithmetic(10, 3)
puts result[:sum]        # => 13
puts result[:difference] # => 7
puts result[:product]    # => 30
puts result[:quotient]   # => 3.3333333333333335
puts result[:modulo]     # => 1
puts result[:power]      # => 1000

# ------------------------------------------------------------
# Exercise 3: compare
# ------------------------------------------------------------
# Comparison operators always return true or false (booleans).
# Putting them directly as Hash values is clean and idiomatic Ruby —
# there's no need for an if/else. The three keys cover the fundamental
# relationships between two values: equality, greater-than, less-than.

def compare(a, b)
  {
    equal:   a == b,
    greater: a > b,
    less:    a < b
  }
end

puts compare(10, 20).inspect  # => {:equal=>false, :greater=>false, :less=>true}
puts compare(5, 5).inspect    # => {:equal=>true, :greater=>false, :less=>false}
puts compare(20, 10).inspect  # => {:equal=>false, :greater=>true, :less=>false}

# ------------------------------------------------------------
# Exercise 4: convert_to_int
# ------------------------------------------------------------
# Ruby's .to_i method is defined on all common types: String, Float,
# NilClass, and more. It never raises an error — it returns 0 if
# conversion is impossible (e.g., "abc".to_i => 0).
# For Floats, it truncates toward zero: 3.9.to_i => 3, -3.9.to_i => -3.
# This is different from rounding — use .round if you want rounding.

def convert_to_int(val)
  val.to_i
end

puts convert_to_int("42")    # => 42
puts convert_to_int(3.9)     # => 3
puts convert_to_int(nil)     # => 0
puts convert_to_int("7px")   # => 7
puts convert_to_int("abc")   # => 0

# ------------------------------------------------------------
# Exercise 5: convert_to_string
# ------------------------------------------------------------
# .to_s is available on every Ruby object. It produces a human-readable
# String representation. For nil, it returns "" (empty string), which is
# a safe default. For Symbols, .to_s strips the leading colon: :hello => "hello".
# This is the standard way to coerce values to strings before concatenating
# or interpolating them in output.

def convert_to_string(val)
  val.to_s
end

puts convert_to_string(42).inspect      # => "42"
puts convert_to_string(3.14).inspect    # => "3.14"
puts convert_to_string(true).inspect    # => "true"
puts convert_to_string(nil).inspect     # => ""
puts convert_to_string(:hello).inspect  # => "hello"
