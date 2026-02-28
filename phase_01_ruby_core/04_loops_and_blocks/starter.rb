# frozen_string_literal: true

# ============================================================
# Lesson 04 — Loops and Blocks
# starter.rb — Working starter code with TODOs and Hints
# ============================================================
# Run this file with:  ruby starter.rb
# ============================================================

# ------------------------------------------------------------
# PART 1: times / upto / downto
# ------------------------------------------------------------

# Already works — study the pattern
puts "--- times ---"
3.times { |i| puts "Lap #{i}" }
# => Lap 0
# => Lap 1
# => Lap 2

puts "--- upto ---"
1.upto(4) { |n| puts n }
# => 1  2  3  4

# TODO: Use downto to print numbers from 5 down to 1
# Hint: start_number.downto(end_number) { |n| puts n }
puts "--- downto ---"
# TODO: 5.downto(?) { |n| ... }

# TODO: Use downto to build an Array called `countdown` holding [5, 4, 3, 2, 1]
# Hint: start with countdown = []
#       then 5.downto(1) { |n| countdown << n }
countdown = []
# TODO: fill countdown using downto

puts countdown.inspect   # expected: [5, 4, 3, 2, 1]

# ------------------------------------------------------------
# PART 2: while / until
# ------------------------------------------------------------

puts "\n--- while ---"

# Already works — study it
total = 0
i = 1
while i <= 5
  total += i
  i += 1
end
puts "Sum 1..5 = #{total}"   # => 15

# TODO: Write a while loop that doubles `value` until it exceeds 100
# Hint: start with value = 1, then value *= 2 inside the loop
value = 1
# TODO: while value <= 100 ...

puts "First value > 100: #{value}"   # expected: 128

puts "\n--- until ---"

# TODO: Use until to count up from 0 to 5 (stop when counter reaches 5)
# Hint: until counter == 5 do ... counter += 1 ... end
counter = 0
# TODO: until counter == 5 ...

puts "Counter reached: #{counter}"   # expected: 5

# ------------------------------------------------------------
# PART 3: each with blocks
# ------------------------------------------------------------

puts "\n--- each ---"

# Already works — study it
fruits = ["apple", "banana", "cherry"]
fruits.each { |f| puts f }

# TODO: Use each to build a sum of [10, 20, 30, 40] WITHOUT using .sum
# Hint: start with running_sum = 0
#       then array.each { |n| running_sum += n }
numbers = [10, 20, 30, 40]
running_sum = 0
# TODO: iterate numbers with each and accumulate into running_sum

puts "Sum: #{running_sum}"   # expected: 100

# ------------------------------------------------------------
# PART 4: reduce / inject
# ------------------------------------------------------------

puts "\n--- reduce / inject ---"

# Already works — study it
product = [1, 2, 3, 4, 5].reduce(1) { |acc, n| acc * n }
puts "Product: #{product}"   # => 120

# TODO: Use reduce to find the sum of [3, 7, 2, 8, 5]
# Hint: array.reduce(0) { |acc, n| acc + n }
my_sum = [3, 7, 2, 8, 5].reduce(0) do |acc, n|
  # TODO: return acc + n
end

puts "My sum: #{my_sum}"   # expected: 25

# TODO: Use the symbol shorthand to find the product of [2, 3, 4]
# Hint: array.reduce(:*)
shorthand_product = [2, 3, 4].reduce(:+)   # TODO: change :+ to :*
puts "Shorthand product: #{shorthand_product}"   # expected: 24

# ------------------------------------------------------------
# PART 5: each_with_object
# ------------------------------------------------------------

puts "\n--- each_with_object ---"

# Already works — study it
doubled = [1, 2, 3].each_with_object([]) { |n, arr| arr << n * 2 }
puts doubled.inspect   # => [2, 4, 6]

# TODO: Use each_with_object to build a Hash from this array of pairs
# Hint: pairs.each_with_object({}) { |(key, value), hash| hash[key] = value }
pairs = [[:name, "Alice"], [:age, 30], [:role, "Engineer"]]
person = pairs.each_with_object({}) do |(key, val), hash|
  # TODO: hash[key] = val
end

puts person.inspect   # expected: {:name=>"Alice", :age=>30, :role=>"Engineer"}

# TODO: Use each_with_object to group ["cat", "ox", "bee", "ant"] by word length
# Hint: result = words.each_with_object({}) { |word, h| ... h[word.length] ||= []; h[word.length] << word }
words = ["cat", "ox", "bee", "ant"]
by_length = words.each_with_object({}) do |word, h|
  # TODO: group words by their length
  # Hint: h[word.length] ||= []
  #       h[word.length] << word
end

puts by_length.inspect   # expected: {3=>["cat", "bee", "ant"], 2=>["ox"]}

# ------------------------------------------------------------
# PART 6: yield basics
# ------------------------------------------------------------

puts "\n--- yield ---"

# Already works — study it
def shout
  result = yield if block_given?
  puts result.to_s.upcase
end

shout { "hello from the block" }   # => HELLO FROM THE BLOCK

# TODO: Complete the method so it yields each number from 1 to n
# Hint: 1.upto(n) { |i| yield(i) }
def call_each_up_to(n)
  # TODO: yield each integer from 1 up to n
  # Hint: 1.upto(n) { |i| yield i }
end

call_each_up_to(4) { |i| puts "Got: #{i}" }
# expected:
# Got: 1
# Got: 2
# Got: 3
# Got: 4

# TODO: Write a method `run_and_collect(n)` that yields 1..n and
#       collects the block's return values into an Array
# Hint: Use (1..n).map { |i| yield(i) }
def run_and_collect(n)
  # TODO: collect yield results
end

results = run_and_collect(5) { |i| i * i }
puts results.inspect   # expected: [1, 4, 9, 16, 25]

# ============================================================
# Run this file to see your output:  ruby starter.rb
# When all TODOs are filled in, the output should match the
# comments showing expected values.
# ============================================================
