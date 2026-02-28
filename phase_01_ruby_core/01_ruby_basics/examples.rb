# frozen_string_literal: true

# ============================================================
# Lesson 01 — Ruby Basics
# examples.rb — Complete runnable examples
# ============================================================
# Run with:  ruby examples.rb
# ============================================================

puts "=" * 60
puts "LESSON 01: Ruby Basics"
puts "=" * 60

# ------------------------------------------------------------
# 1. Data Types
# ------------------------------------------------------------
puts "\n--- 1. Data Types ---"

my_string  = "Hello, Ruby!"
my_integer = 42
my_float   = 3.14
my_true    = true
my_false   = false
my_nil     = nil
my_symbol  = :status

puts my_string.class    # => String
puts my_integer.class   # => Integer
puts my_float.class     # => Float
puts my_true.class      # => TrueClass
puts my_false.class     # => FalseClass
puts my_nil.class       # => NilClass
puts my_symbol.class    # => Symbol

# Strings can use single or double quotes
single_quoted = 'no interpolation: #{1 + 1}'
double_quoted = "with interpolation: #{1 + 1}"
puts single_quoted  # => no interpolation: #{1 + 1}
puts double_quoted  # => with interpolation: 2

# Symbols are memory-efficient labels — same symbol is always the same object
puts :foo.object_id == :foo.object_id    # => true
puts "foo".object_id == "foo".object_id  # => false (different objects)

# ------------------------------------------------------------
# 2. Variable Assignment
# ------------------------------------------------------------
puts "\n--- 2. Variable Assignment ---"

# Single assignment
count = 0
count = count + 1
puts count   # => 1

# Compound assignment operators (shortcuts)
score = 10
score += 5   # same as score = score + 5
puts score   # => 15
score -= 3
puts score   # => 12
score *= 2
puts score   # => 24
score /= 4
puts score   # => 6

# Multiple assignment (parallel assignment)
x, y, z = 1, 2, 3
puts "#{x}, #{y}, #{z}"   # => 1, 2, 3

# Swap two variables without a temp variable
a, b = 10, 20
a, b = b, a
puts "a=#{a}, b=#{b}"   # => a=20, b=10

# ------------------------------------------------------------
# 3. Arithmetic Operators
# ------------------------------------------------------------
puts "\n--- 3. Arithmetic Operators ---"

n1 = 17
n2 = 5

puts n1 + n2    # => 22   (addition)
puts n1 - n2    # => 12   (subtraction)
puts n1 * n2    # => 85   (multiplication)
puts n1 / n2    # => 3    (integer division — truncates toward zero)
puts n1 % n2    # => 2    (modulo — remainder after division)
puts n1 ** n2   # => 1419857  (exponentiation: 17^5)

# Float division
puts n1.to_f / n2   # => 3.4
puts 1.0 / 3        # => 0.3333333333333333

# Modulo use-case: even/odd detection
puts 10 % 2 == 0   # => true  (10 is even)
puts 7  % 2 == 0   # => false (7 is odd)

# Exponentiation use-case: area/volume
radius = 5
area = Math::PI * radius ** 2
puts area.round(2)   # => 78.54

# ------------------------------------------------------------
# 4. Comparison Operators
# ------------------------------------------------------------
puts "\n--- 4. Comparison Operators ---"

p = 10
q = 20

puts p == q   # => false  (equal?)
puts p != q   # => true   (not equal?)
puts p >  q   # => false  (greater than?)
puts p <  q   # => true   (less than?)
puts p >= q   # => false  (greater than or equal?)
puts p <= q   # => true   (less than or equal?)

# Comparing strings (alphabetical / lexicographic order)
puts "apple" < "banana"   # => true
puts "zebra" > "ant"      # => true
puts "abc" == "abc"       # => true

# Comparison returns a boolean — usable in conditionals
temperature = 38.5
puts "Fever!" if temperature > 37.5   # => Fever!

# Spaceship operator <=> returns -1, 0, or 1
puts (5 <=> 10)   # => -1  (5 is less than 10)
puts (10 <=> 10)  # => 0   (equal)
puts (15 <=> 10)  # => 1   (15 is greater)

# ------------------------------------------------------------
# 5. Type Conversion
# ------------------------------------------------------------
puts "\n--- 5. Type Conversion ---"

# String → Integer
puts "42".to_i        # => 42
puts "  99  ".to_i    # => 99   (strips whitespace)
puts "3abc".to_i      # => 3    (stops at first non-digit)
puts "abc".to_i       # => 0    (no leading digit → 0)

# String → Float
puts "3.14".to_f      # => 3.14
puts "1.5e2".to_f     # => 150.0

# Integer / Float → String
puts 42.to_s          # => "42"
puts 3.14.to_s        # => "3.14"
puts 255.to_s(16)     # => "ff"   (base-16 hex)
puts 8.to_s(2)        # => "1000" (base-2 binary)

# Float → Integer (truncates — does NOT round)
puts 3.9.to_i    # => 3   (NOT 4)
puts -3.9.to_i   # => -3  (toward zero)

# nil converts safely to zero / empty
puts nil.to_i         # => 0
puts nil.to_f         # => 0.0
puts nil.to_s.inspect # => ""
puts nil.to_a.inspect # => []

# Chained conversion
raw_input = "  42.7  "
value = raw_input.strip.to_f.round
puts value             # => 43

# ------------------------------------------------------------
# 6. Putting It Together — Real-World Mini Example
# ------------------------------------------------------------
puts "\n--- 6. Real-World: Product Pricing ---"

# Simulating a row from a CSV / web form (all values arrive as Strings)
product_name  = "Wireless Headphones"
price_string  = "79.99"
quantity_string = "3"
discount_pct  = "10"

price    = price_string.to_f
quantity = quantity_string.to_i
discount = discount_pct.to_i

subtotal       = price * quantity
discount_amount = subtotal * (discount / 100.0)
total          = subtotal - discount_amount

puts "Product:  #{product_name}"
puts "Price:    $#{"%.2f" % price}"
puts "Quantity: #{quantity}"
puts "Subtotal: $#{"%.2f" % subtotal}"
puts "Discount: -$#{"%.2f" % discount_amount} (#{discount}%)"
puts "Total:    $#{"%.2f" % total}"
# => Product:  Wireless Headphones
# => Price:    $79.99
# => Quantity: 3
# => Subtotal: $239.97
# => Discount: -$24.00 (10%)
# => Total:    $215.97

puts "\n" + "=" * 60
puts "All examples complete!"
puts "=" * 60
