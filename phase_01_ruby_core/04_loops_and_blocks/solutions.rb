# frozen_string_literal: true

# ============================================================
# Lesson 04 — Loops and Blocks
# solutions.rb — Solutions with plain-language explanations
# ============================================================

# ------------------------------------------------------------
# Exercise 1: countdown(n)
# ------------------------------------------------------------
# downto is an Integer method that counts from receiver down to the
# argument (inclusive), yielding each integer to a block.
# We collect each yielded value into an Array and return it.
# Using downto (rather than reverse or sort) makes the intent
# immediately clear: we are explicitly counting downwards.

def countdown(n)
  result = []
  n.downto(1) { |i| result << i }
  result
end

puts countdown(5).inspect   # => [5, 4, 3, 2, 1]
puts countdown(3).inspect   # => [3, 2, 1]
puts countdown(1).inspect   # => [1]

# ------------------------------------------------------------
# Exercise 2: factorial(n)
# ------------------------------------------------------------
# reduce (alias: inject) collapses a collection to a single value
# by applying the block repeatedly. Starting from the left,
# it calls block(accumulator, next_element) and uses the result
# as the new accumulator.
# (1..n).reduce(:*) multiplies every integer from 1 to n together.
# We handle the n == 0 edge case explicitly because (1..0) is an
# empty range and reduce on an empty range with no initial value
# raises an error — and mathematically 0! = 1.

def factorial(n)
  return 1 if n == 0

  (1..n).reduce(:*)
end

puts factorial(0)   # => 1
puts factorial(1)   # => 1
puts factorial(5)   # => 120
puts factorial(6)   # => 720

# ------------------------------------------------------------
# Exercise 3: sum_with_each(arr)
# ------------------------------------------------------------
# each iterates every element without transforming the array.
# We maintain a running total manually, incrementing it inside
# the block. This demonstrates the accumulator pattern — the
# same idea that reduce automates — but written explicitly with
# each so the mechanics are transparent.

def sum_with_each(arr)
  total = 0
  arr.each { |n| total += n }
  total
end

puts sum_with_each([1, 2, 3, 4])   # => 10
puts sum_with_each([10, 20, 30])   # => 60
puts sum_with_each([])             # => 0

# ------------------------------------------------------------
# Exercise 4: group_by_length(arr)
# ------------------------------------------------------------
# each_with_object passes the SAME object (here, an empty Hash)
# into every iteration as the second block parameter.
# We mutate that hash inside the block — NOT reassign it.
# `h[word.length] ||= []` initialises the array on first encounter,
# then `<< word` appends the word to whichever bucket it belongs to.
# The method automatically returns the final, populated Hash.

def group_by_length(arr)
  arr.each_with_object({}) do |word, h|
    h[word.length] ||= []
    h[word.length] << word
  end
end

puts group_by_length(["cat", "ox", "bee", "ant"]).inspect
# => {3=>["cat", "bee", "ant"], 2=>["ox"]}

puts group_by_length(["hello", "hi", "hey", "world"]).inspect
# => {5=>["hello", "world"], 2=>["hi"], 3=>["hey"]}

puts group_by_length([]).inspect
# => {}

# ------------------------------------------------------------
# Exercise 5: run_and_collect(n)
# ------------------------------------------------------------
# yield passes control — and a value — to whatever block the caller
# supplies. (1..n).map iterates 1 through n and collects each
# iteration's return value into a new Array automatically.
# The block_given? guard is optional here since map always has
# an implicit block, but it is good practice to add it when
# yield might otherwise cause a LocalJumpError.

def run_and_collect(n)
  (1..n).map { |i| yield(i) }
end

puts run_and_collect(3) { |i| i * 2 }.inspect    # => [2, 4, 6]
puts run_and_collect(4) { |i| i**2 }.inspect     # => [1, 4, 9, 16]
puts run_and_collect(5) { |i| i }.inspect        # => [1, 2, 3, 4, 5]
