# frozen_string_literal: true

# ============================================================
# Lesson 05 — Methods, Procs, and Lambdas
# starter.rb — Working starter code with TODOs and Hints
# ============================================================
# Run this file with:  ruby starter.rb
# ============================================================

# ------------------------------------------------------------
# PART 1: Basic Methods
# ------------------------------------------------------------

# This method already works — study it, then modify it below
def greet(name)
  "Hello, #{name}!"
end

puts greet("World")   # => Hello, World!

# Study this completed example, then write your own variations below.
# Hint: Keyword args look like:  def foo(name, title: "Default")
def greet_formal(name, title: "Ms.")
  "Good day, #{title} #{name}."
end

puts greet_formal("Smith")             # => Good day, Ms. Smith.
puts greet_formal("Jones", title: "Dr.")  # => Good day, Dr. Jones.

# ------------------------------------------------------------
# PART 2: Splat Arguments (*args)
# ------------------------------------------------------------

# Already works — study the pattern
def list_items(*items)
  items.each_with_index do |item, i|
    puts "#{i + 1}. #{item}"
  end
end

list_items("apples", "bananas", "cherries")

# TODO: Write a method `sum_all` that accepts any number of numbers
#       and returns their sum
# Hint: Use *numbers as the parameter
# Hint: Use .sum on the array, or use .reduce(:+)
def sum_all(*numbers)
  # TODO: return the sum of all numbers
  # Hint: numbers is an Array here
end

puts sum_all(1, 2, 3)       # => 6
puts sum_all(10, 20, 30, 40) # => 100

# ------------------------------------------------------------
# PART 3: Procs
# ------------------------------------------------------------

# Already works — study the pattern
shout = Proc.new { |text| text.upcase + "!" }
puts shout.call("hello")   # => HELLO!

# TODO: Create a Proc called `titleize` that capitalizes the first
#       letter of each word in a string
# Hint: Use .split to break into words
# Hint: Use .map with &:capitalize to capitalize each word
# Hint: Use .join(" ") to put them back together
titleize = Proc.new do |text|
  # TODO: split → capitalize each word → join
end

puts titleize.call("hello world from ruby")   # => Hello World From Ruby

# ------------------------------------------------------------
# PART 4: Lambdas
# ------------------------------------------------------------

# Already works — study the pattern
double = lambda { |n| n * 2 }
puts double.call(7)   # => 14

# Shorter arrow syntax (same thing):
triple = ->(n) { n * 3 }
puts triple.call(4)   # => 12

# TODO: Create a lambda called `safe_divide` that divides two numbers
#       Return nil if the divisor (second argument) is zero
# Hint: Use an if/else or ternary inside the lambda
# Hint: Check if b == 0
safe_divide = lambda do |a, b|
  # TODO: return nil if b is zero, otherwise return a / b.to_f
end

puts safe_divide.call(10, 2)   # => 5.0
puts safe_divide.call(10, 0).inspect  # => nil

# ------------------------------------------------------------
# PART 5: Yield
# ------------------------------------------------------------

# Already works — study the pattern
def measure
  start = Time.now
  yield if block_given?
  elapsed = Time.now - start
  puts "Elapsed: #{elapsed.round(4)}s"
end

measure { sleep(0.01) }

# TODO: Write a method `repeat` that takes a number `n` and
#       yields to the block n times
# Hint: Use n.times do ... yield ... end
# Hint: Optionally pass the iteration index to the block
def repeat(n)
  # TODO: yield n times
  # Hint: n.times { |i| yield i }
end

repeat(3) { |i| puts "Iteration #{i}" }
# => Iteration 0
# => Iteration 1
# => Iteration 2

# ------------------------------------------------------------
# PART 6: Passing Blocks with &
# ------------------------------------------------------------

def square(n) = n**2

numbers = [1, 2, 3, 4, 5]

# Pass a method as a block using &method(:name)
squared = numbers.map(&method(:square))
puts squared.inspect   # => [1, 4, 9, 16, 25]

# &:symbol shorthand — calls that method on each element
words = ["hello", "world", "ruby"]
puts words.map(&:upcase).inspect   # => ["HELLO", "WORLD", "RUBY"]
puts words.map(&:length).inspect   # => [5, 5, 4]

# ============================================================
# Run this file to see your output:  ruby starter.rb
# When all TODOs are filled in, the output should match the
# comments showing expected values.
# ============================================================
