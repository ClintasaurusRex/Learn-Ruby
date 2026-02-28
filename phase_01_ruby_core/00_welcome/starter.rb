# frozen_string_literal: true

# ============================================================
# Lesson 00 — Welcome to Ruby
# starter.rb — Working starter code with TODOs and Hints
# ============================================================
# Run this file with:  ruby starter.rb
# ============================================================

# ------------------------------------------------------------
# PART 1: puts, print, and p
# ------------------------------------------------------------

# puts adds a newline at the end automatically
puts "Hello, Ruby!"   # => Hello, Ruby!

# print does NOT add a newline — output continues on the same line
print "one "
print "two "
print "three"
print "\n"   # manual newline

# p shows the raw Ruby inspect representation (useful for debugging)
p "Hello"    # => "Hello"   (with quotes — it's clearly a String)
p 42         # => 42
p nil        # => nil

# TODO: Use puts to print your name
# Hint: puts "Your name here"

# TODO: Use print three times to print three words on ONE line, then add "\n"
# Hint: print "word1 "; print "word2 "; print "word3\n"

# TODO: Use p to inspect an Array — notice it stays on one line
# Hint: p [10, 20, 30]

# ------------------------------------------------------------
# PART 2: String Interpolation
# ------------------------------------------------------------

# Already works — study the pattern
name = "Alice"
age  = 30
puts "My name is #{name} and I am #{age} years old."
# => My name is Alice and I am 30 years old.

# You can put any Ruby expression inside #{ }
puts "Two plus two is #{2 + 2}."   # => Two plus two is 4.
puts "Name upcased: #{"ruby".upcase}."  # => Name upcased: RUBY.

# TODO: Create a variable `city` with your city name
# TODO: Interpolate it into a sentence: "I live in ___."
# Hint: city = "London"
#       puts "I live in #{city}."

# TODO: Interpolate a math expression: show what 7 * 8 equals
# Hint: puts "7 times 8 is #{7 * 8}."

# ------------------------------------------------------------
# PART 3: Comments
# ------------------------------------------------------------

# This is a single-line comment — Ruby ignores everything after #
# Use comments to explain WHY, not just WHAT

x = 100   # x holds the high score

# TODO: Add a comment above this line explaining what `y` is for
y = 42

# Multi-line comments are just multiple # lines
# Line one of the comment
# Line two of the comment
# Line three of the comment

# TODO: Add a 3-line comment block explaining what this program does

# ------------------------------------------------------------
# PART 4: IRB Basics (demonstration in comments)
# ------------------------------------------------------------

# IRB (Interactive Ruby) — open it by typing `irb` in your terminal
#
# irb> 2 + 2           => 4
# irb> "hello".upcase  => "HELLO"
# irb> [1,2,3].sum     => 6
# irb> exit            (quit IRB)
#
# The => arrow shows the RETURN VALUE of the expression.
# puts in IRB prints output AND shows => nil (puts always returns nil).

# TODO: Open IRB in a separate terminal and try these:
#   "Ruby".reverse
#   (1..5).to_a
#   "hello world".split

# ------------------------------------------------------------
# PART 5: puts vs p side-by-side
# ------------------------------------------------------------

items = ["apple", "banana", "cherry"]

puts "--- puts with an array ---"
puts items   # each element on its own line — no brackets

puts "--- p with an array ---"
p items      # => ["apple", "banana", "cherry"]  — full inspect

str_with_tab = "hello\tworld"
puts "--- puts string with tab ---"
puts str_with_tab   # tab is rendered as whitespace

puts "--- p string with tab ---"
p str_with_tab      # => "hello\tworld"  — escape shown literally

# ============================================================
# Run this file to see your output:  ruby starter.rb
# Fill in the TODOs and re-run to see the new output.
# ============================================================
