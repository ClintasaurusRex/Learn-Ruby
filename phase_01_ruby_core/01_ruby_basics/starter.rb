# frozen_string_literal: true

# ============================================================
# Lesson 01 — Ruby Basics
# starter.rb — Working starter code with TODOs and Hints
# ============================================================
# Run this file with:  ruby starter.rb
# ============================================================

# ------------------------------------------------------------
# PART 1: Data Types
# ------------------------------------------------------------

# These variables already work — study the types, then add your own below
name    = "Alice"
age     = 30
height  = 5.7
active  = true
nothing = nil
role    = :admin

puts name.class    # => String
puts age.class     # => Integer
puts height.class  # => Float
puts active.class  # => TrueClass
puts nothing.class # => NilClass
puts role.class    # => Symbol

# TODO: Create your own variable for each of the 6 data types
# Hint: A String is text in quotes: "hello"
# Hint: An Integer is a whole number: 42
# Hint: A Float is a decimal number: 3.14
# Hint: A Boolean is true or false (no quotes)
# Hint: nil means "nothing" — just write nil
# Hint: A Symbol starts with a colon: :my_symbol

# my_string  = ???
# my_integer = ???
# my_float   = ???
# my_boolean = ???
# my_nil     = ???
# my_symbol  = ???

# ------------------------------------------------------------
# PART 2: Arithmetic Operators
# ------------------------------------------------------------

# Already works — study the operators
a = 10
b = 3

puts "#{a} + #{b} = #{a + b}"   # => 10 + 3 = 13
puts "#{a} - #{b} = #{a - b}"   # => 10 - 3 = 7
puts "#{a} * #{b} = #{a * b}"   # => 10 * 3 = 30
puts "#{a} / #{b} = #{a / b}"   # => 10 / 3 = 3  (integer division!)
puts "#{a} % #{b} = #{a % b}"   # => 10 % 3 = 1  (remainder)
puts "#{a} ** #{b} = #{a ** b}" # => 10 ** 3 = 1000 (power)

# TODO: Fix the integer division problem to get 3.333...
# Hint: Convert one operand to Float first using .to_f
# float_result = a.to_f / b
# puts float_result   # => 3.3333333333333335

# TODO: Calculate the area of a circle with radius 7
# Hint: area = Math::PI * radius ** 2
# radius = 7
# area   = ???
# puts area.round(2)   # => 153.94

# ------------------------------------------------------------
# PART 3: Comparison Operators
# ------------------------------------------------------------

# Already works — study the pattern
x = 10
y = 20

puts x == y   # => false  (equal?)
puts x != y   # => true   (not equal?)
puts x > y    # => false  (greater than?)
puts x < y    # => true   (less than?)
puts x >= y   # => false  (greater than or equal?)
puts x <= y   # => true   (less than or equal?)

# TODO: Compare two strings — does Ruby compare them alphabetically?
# Hint: "apple" < "banana" should be true (alphabetical order)
# puts "apple" < "banana"   # => ???
# puts "zebra" > "ant"      # => ???

# TODO: What happens when you compare a String to an Integer?
# Hint: Try:  puts 3 == "3"   — what do you expect?

# ------------------------------------------------------------
# PART 4: Type Conversion
# ------------------------------------------------------------

# Already works — study the conversions
puts "42".to_i        # => 42    (String → Integer)
puts "3.14".to_f      # => 3.14  (String → Float)
puts 42.to_s          # => "42"  (Integer → String)
puts 3.14.to_i        # => 3     (Float → Integer — truncates!)
puts 10.to_f / 3      # => 3.3333333333333335

# TODO: Convert the string "100" to an Integer, double it, then convert back to String
# Hint: "100".to_i gives you 100
# Hint: Then multiply by 2
# Hint: Then call .to_s
# result = ???
# puts result   # => "200"

# TODO: What does converting a non-numeric string give you?
# Hint: Try "hello".to_i  — Ruby won't raise an error, but what does it return?
# puts "hello".to_i    # => ???
# puts "hello".to_f    # => ???

# TODO: Safely convert nil to each type
# puts nil.to_i    # => ???
# puts nil.to_f    # => ???
# puts nil.to_s.inspect   # => ???  (hint: inspect shows the exact value)

# ============================================================
# Run this file to see your output:  ruby starter.rb
# When all TODOs are filled in, the output should match the
# comments showing expected values.
# ============================================================
