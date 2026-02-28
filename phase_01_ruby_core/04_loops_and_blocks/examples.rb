# frozen_string_literal: true

# ============================================================
# Lesson 04 — Loops and Blocks
# examples.rb — Complete runnable examples
# ============================================================
# Run with:  ruby examples.rb
# ============================================================

puts "=" * 60
puts "LESSON 04: Loops and Blocks"
puts "=" * 60

# ------------------------------------------------------------
# 1. times / upto / downto
# ------------------------------------------------------------
puts "\n--- 1. times / upto / downto ---"

# times — runs the block N times, yielding index 0..N-1
print "times:   "
3.times { |i| print "#{i} " }
puts
# => times:   0 1 2

# upto — from receiver up to limit (inclusive)
print "upto:    "
1.upto(5) { |n| print "#{n} " }
puts
# => upto:    1 2 3 4 5

# downto — from receiver down to limit (inclusive)
print "downto:  "
5.downto(1) { |n| print "#{n} " }
puts
# => downto:  5 4 3 2 1

# Building an array with downto
countdown = []
5.downto(1) { |n| countdown << n }
puts "countdown array: #{countdown.inspect}"
# => countdown array: [5, 4, 3, 2, 1]

# step — iterate with a custom step size
print "step:    "
1.step(10, 2) { |n| print "#{n} " }
puts
# => step:    1 3 5 7 9

# ------------------------------------------------------------
# 2. while / until
# ------------------------------------------------------------
puts "\n--- 2. while / until ---"

# while — loop while condition is true
n = 1
while n < 32
  n *= 2
end
puts "First power of 2 >= 32: #{n}"   # => 32

# until — loop until condition becomes true (opposite of while)
seconds = 0
until seconds >= 5
  seconds += 1
end
puts "Counted to: #{seconds}"   # => 5

# begin...end while (do…while equivalent — always runs at least once)
attempt = 0
begin
  attempt += 1
end while attempt < 3
puts "Attempts: #{attempt}"   # => 3

# loop with break
x = 0
loop do
  x += 1
  break if x == 4
end
puts "loop broke at x=#{x}"   # => loop broke at x=4

# next — skip to next iteration
print "odd only: "
1.upto(10) do |i|
  next if i.even?
  print "#{i} "
end
puts
# => odd only: 1 3 5 7 9

# ------------------------------------------------------------
# 3. each with blocks
# ------------------------------------------------------------
puts "\n--- 3. each with blocks ---"

# Basic each
total = 0
[10, 20, 30, 40].each { |n| total += n }
puts "Manual sum: #{total}"   # => 100

# each_with_index — index is the second block param
["alpha", "beta", "gamma"].each_with_index do |word, idx|
  puts "  #{idx}: #{word}"
end
# => 0: alpha
# => 1: beta
# => 2: gamma

# each on a Hash
{ a: 1, b: 2, c: 3 }.each do |key, value|
  puts "  #{key} => #{value}"
end
# => a => 1
# => b => 2
# => c => 3

# ------------------------------------------------------------
# 4. reduce / inject
# ------------------------------------------------------------
puts "\n--- 4. reduce / inject ---"

numbers = [1, 2, 3, 4, 5]

# Sum with explicit initial value and block
sum = numbers.reduce(0) { |acc, n| acc + n }
puts "sum:      #{sum}"   # => 15

# Product with explicit initial value
product = numbers.reduce(1) { |acc, n| acc * n }
puts "product:  #{product}"   # => 120

# Symbol shorthand — much shorter
puts "reduce +:  #{numbers.reduce(:+)}"   # => 15
puts "reduce *:  #{numbers.reduce(:*)}"   # => 120

# inject is a full alias for reduce
puts "inject +:  #{numbers.inject(:+)}"   # => 15

# Building a string with reduce
words = ["Loops", "and", "Blocks"]
sentence = words.reduce { |acc, w| "#{acc} #{w}" }
puts "sentence: #{sentence}"   # => Loops and Blocks

# Factorial using reduce
factorial = (1..6).reduce(:*)
puts "6!:       #{factorial}"   # => 720

# Max without using .max
max_val = [3, 7, 1, 9, 4].reduce { |m, n| n > m ? n : m }
puts "max:      #{max_val}"   # => 9

# ------------------------------------------------------------
# 5. each_with_object
# ------------------------------------------------------------
puts "\n--- 5. each_with_object ---"

# Build an array of squares
squares = (1..5).each_with_object([]) { |n, arr| arr << n**2 }
puts "squares:  #{squares.inspect}"   # => [1, 4, 9, 16, 25]

# Build a Hash mapping word => length
words = ["apple", "banana", "cherry"]
lengths = words.each_with_object({}) { |w, h| h[w] = w.length }
puts "lengths:  #{lengths.inspect}"
# => {"apple"=>5, "banana"=>6, "cherry"=>6}

# Group words by first letter
animals = ["ant", "bear", "ape", "bison", "cat"]
by_letter = animals.each_with_object(Hash.new { |h, k| h[k] = [] }) do |animal, groups|
  groups[animal[0]] << animal
end
puts "by_letter: #{by_letter.inspect}"
# => {"a"=>["ant", "ape"], "b"=>["bear", "bison"], "c"=>["cat"]}

# Group strings by length
strs = ["cat", "ox", "bee", "ant", "elephant"]
by_length = strs.each_with_object({}) do |word, h|
  h[word.length] ||= []
  h[word.length] << word
end
puts "by_length: #{by_length.inspect}"
# => {3=>["cat", "bee", "ant"], 2=>["ox"], 8=>["elephant"]}

# Frequency counter using Hash.new(0) as the object
sentence = "the quick brown fox jumps over the lazy dog"
freq = sentence.split.each_with_object(Hash.new(0)) do |word, counts|
  counts[word] += 1
end
puts "repeated: #{freq.select { |_, v| v > 1 }.inspect}"
# => {"the"=>2}

# ------------------------------------------------------------
# 6. yield basics
# ------------------------------------------------------------
puts "\n--- 6. yield ---"

# Basic yield — hand control to the caller's block
def greet_with_block(name)
  puts "Before yield"
  yield(name) if block_given?
  puts "After yield"
end

greet_with_block("Ruby") { |n| puts "  Hello, #{n}!" }
# => Before yield
# =>   Hello, Ruby!
# => After yield

# yield with a return value
def transform(value)
  yield(value)
end
result = transform(6) { |n| n * n }
puts "transform(6) { n*n }: #{result}"   # => 36

# Collecting yield results — the core of run_and_collect
def run_and_collect(n)
  (1..n).map { |i| yield(i) }
end

doubles = run_and_collect(5) { |i| i * 2 }
puts "run_and_collect doubles: #{doubles.inspect}"   # => [2, 4, 6, 8, 10]

# block_given? — makes the block optional
def maybe_block(n)
  if block_given?
    yield(n)
  else
    n * n
  end
end
puts "with block:    #{maybe_block(4) { |n| n + 100 }}"   # => 104
puts "without block: #{maybe_block(4)}"                    # => 16

# Capturing a block with &block for later use
def save_for_later(&block)
  @saved_block = block
end

def run_saved(arg)
  @saved_block&.call(arg)
end

save_for_later { |x| "result: #{x * 3}" }
puts run_saved(7)   # => result: 21

puts "\n" + "=" * 60
puts "All examples complete!"
puts "=" * 60
