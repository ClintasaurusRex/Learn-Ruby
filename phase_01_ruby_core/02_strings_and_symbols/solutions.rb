# frozen_string_literal: true

# ============================================================
# Lesson 02 — Strings and Symbols
# solutions.rb — Solutions with plain-language explanations
# ============================================================

# ------------------------------------------------------------
# Exercise 1: shout
# ------------------------------------------------------------
# .upcase returns a new string with all characters uppercased.
# We then concatenate "!" using + or embed with #{}.
# Because frozen_string_literal is true we use non-bang .upcase
# (not .upcase!) which safely returns a new string without
# mutating the receiver.

def shout(str)
  str.upcase + "!"
end

puts shout("hello")          # => HELLO!
puts shout("ruby is great")  # => RUBY IS GREAT!

# ------------------------------------------------------------
# Exercise 2: titleize
# ------------------------------------------------------------
# .split with no argument splits on any whitespace and discards
# empty tokens — it gives us an array of words.
# .map(&:capitalize) is Symbol#to_proc shorthand for
# { |word| word.capitalize }, which upcases the first character
# and lowercases the rest.
# .join(" ") reassembles the words into a single string with
# a single space between each word.

def titleize(str)
  str.split.map(&:capitalize).join(" ")
end

puts titleize("hello world")          # => Hello World
puts titleize("the quick brown fox")  # => The Quick Brown Fox

# ------------------------------------------------------------
# Exercise 3: palindrome?
# ------------------------------------------------------------
# We normalize first: .downcase removes case differences so
# "Madam" == "madam", and .strip removes leading/trailing spaces.
# Then we simply compare the normalized string to its .reverse.
# If they are equal, the string reads the same both ways.
# The method name ends with ? by Ruby convention for predicates.

def palindrome?(str)
  normalized = str.downcase.strip
  normalized == normalized.reverse
end

puts palindrome?("racecar")    # => true
puts palindrome?("Madam")      # => true
puts palindrome?("  level  ")  # => true
puts palindrome?("hello")      # => false

# ------------------------------------------------------------
# Exercise 4: string_stats
# ------------------------------------------------------------
# We build a Hash literal with four keys.
# .length returns the total character count (including spaces).
# .split.length splits on whitespace and counts the resulting words.
# .upcase returns the fully uppercased version (non-mutating).
# .reverse returns the string with characters in reverse order.
# Ruby's hash rocket => and symbol-colon : notation are equivalent;
# we use the modern symbol-colon shorthand here.

def string_stats(str)
  {
    length:    str.length,
    words:     str.split.length,
    uppercase: str.upcase,
    reversed:  str.reverse
  }
end

puts string_stats("hello world").inspect
# => {:length=>11, :words=>2, :uppercase=>"HELLO WORLD", :reversed=>"dlrow olleh"}

puts string_stats("Ruby").inspect
# => {:length=>4, :words=>1, :uppercase=>"RUBY", :reversed=>"ybuR"}

# ------------------------------------------------------------
# Exercise 5: symbol_to_strings
# ------------------------------------------------------------
# Every Symbol responds to .to_s which returns the symbol's name
# as a plain String. For example, :hello.to_s => "hello".
# &:to_s uses Symbol#to_proc to convert :to_s into a block
# { |sym| sym.to_s }, then passes it to .map.
# This is the idiomatic "Symbol#to_proc" pattern — concise and clear.

def symbol_to_strings(arr_of_symbols)
  arr_of_symbols.map(&:to_s)
end

puts symbol_to_strings([:hello, :world]).inspect   # => ["hello", "world"]
puts symbol_to_strings([:name, :age, :email]).inspect  # => ["name", "age", "email"]

# ------------------------------------------------------------
# Exercise 6: apply_transform
# ------------------------------------------------------------
# The & operator converts a Symbol into a Proc via Symbol#to_proc.
# When we write arr.map(&transform_sym), Ruby calls
# transform_sym.to_proc to get a Proc, then passes it as the block.
# The Proc calls the named method on each array element.
# This generalizes map: instead of hard-coding the transformation,
# the caller chooses it by passing a symbol.

def apply_transform(arr, transform_sym)
  arr.map(&transform_sym)
end

puts apply_transform(["hello", "world"], :upcase).inspect
# => ["HELLO", "WORLD"]

puts apply_transform(["Hello", "World"], :downcase).inspect
# => ["hello", "world"]

puts apply_transform(["abc", "xyz"], :reverse).inspect
# => ["cba", "zyx"]

puts apply_transform(["  hi  ", "  there  "], :strip).inspect
# => ["hi", "there"]
