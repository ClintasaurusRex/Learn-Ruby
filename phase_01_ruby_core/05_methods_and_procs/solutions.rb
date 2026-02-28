# frozen_string_literal: true

# ============================================================
# Lesson 05 — Methods, Procs, and Lambdas
# solutions.rb — Solutions with plain-language explanations
# ============================================================

# ------------------------------------------------------------
# Exercise 1: format_name
# ------------------------------------------------------------
# We use a case statement to pick the output format.
# Keyword arguments let callers name what they're passing in,
# which makes the call site readable: format_name("John", "Doe", style: :last)
# The default (style: :full) means callers can omit it entirely.

def format_name(first_name, last_name, style: :full)
  case style
  when :full     then "#{first_name} #{last_name}"
  when :last     then "#{last_name}, #{first_name}"
  when :initials then "#{first_name[0]}.#{last_name[0]}."
  end
end

puts format_name("John", "Doe")                    # => John Doe
puts format_name("John", "Doe", style: :last)      # => Doe, John
puts format_name("John", "Doe", style: :initials)  # => J.D.

# ------------------------------------------------------------
# Exercise 2: stats
# ------------------------------------------------------------
# *numbers turns all the arguments into an Array inside the method.
# We then call Array methods on it: .sum, .min, .max, .count.
# .to_f on count ensures the division produces a Float,
# not an integer (which would truncate the decimal).

def stats(*numbers)
  {
    count:   numbers.count,
    sum:     numbers.sum,
    min:     numbers.min,
    max:     numbers.max,
    average: numbers.sum / numbers.count.to_f
  }
end

puts stats(10, 20, 30, 40).inspect
# => {:count=>4, :sum=>100, :min=>10, :max=>40, :average=>25.0}

# ------------------------------------------------------------
# Exercise 3: long_word Proc
# ------------------------------------------------------------
# A Proc is just a block stored in a variable.
# We use word.length > 5 to check the condition.
# The Proc can then be passed to Array#select with &long_word

long_word = Proc.new { |word| word.length > 5 }

words = ["hi", "hello", "elephant", "ox", "cherry"]
puts words.select(&long_word).inspect   # => ["elephant", "cherry"]

# ------------------------------------------------------------
# Exercise 4: safe_sqrt Lambda
# ------------------------------------------------------------
# Math.sqrt(-1) would return NaN, which is confusing.
# We guard against negative input by returning nil explicitly.
# The ternary (condition ? a : b) is concise for simple if/else.
# We use a lambda (not a Proc) because we want strict argument checking.

safe_sqrt = lambda do |n|
  n < 0 ? nil : Math.sqrt(n)
end

puts safe_sqrt.call(9)   # => 3.0
puts safe_sqrt.call(2).round(4)  # => 1.4142
puts safe_sqrt.call(-1).inspect  # => nil

# ------------------------------------------------------------
# Exercise 5: collect_results
# ------------------------------------------------------------
# yield passes the current value to whatever block the caller provides.
# (1..n).map collects the results automatically — each iteration's
# return value from yield becomes one element of the new array.
# This is the core pattern behind Ruby's functional-style iteration.

def collect_results(n)
  (1..n).map { |i| yield(i) }
end

squares = collect_results(5) { |i| i * i }
puts squares.inspect   # => [1, 4, 9, 16, 25]

cubes = collect_results(4) { |i| i ** 3 }
puts cubes.inspect     # => [1, 8, 27, 64]

# ------------------------------------------------------------
# Exercise 6: word_length with method object
# ------------------------------------------------------------
# method(:word_length) grabs a reference to the method as an object.
# Prepending & converts it to a Proc so it can be passed to map.
# This lets you reuse named methods in functional-style pipelines
# without wrapping them in a block manually.

def word_length(str)
  str.length
end

lengths = ["cat", "elephant", "ox"].map(&method(:word_length))
puts lengths.inspect   # => [3, 8, 2]

# ------------------------------------------------------------
# Exercise 7: make_adder (closure)
# ------------------------------------------------------------
# The lambda inside make_adder "closes over" the variable n.
# Even after make_adder returns, n is remembered inside the lambda.
# This is called a closure — the lambda carries its environment with it.
# Each call to make_adder creates a NEW, independent closure.

def make_adder(n)
  lambda { |x| x + n }
end

add_five = make_adder(5)
add_ten  = make_adder(10)

puts add_five.call(3)   # => 8
puts add_ten.call(3)    # => 13
puts add_five.call(20)  # => 25  — add_five still uses n=5
