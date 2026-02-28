# frozen_string_literal: true

# ============================================================
# Lesson 00 — Welcome to Ruby
# examples.rb — Complete runnable demonstrations
# ============================================================
# Run this file with:  ruby examples.rb
# ============================================================

puts "=" * 50
puts "EXAMPLE 1: puts vs print vs p"
puts "=" * 50

# puts — prints the value and adds a newline automatically
puts "Hello from puts"       # Hello from puts
puts 42                      # 42
puts true                    # true
puts nil                     # (blank line — nil becomes "")

# print — prints the value with NO trailing newline
print "A"
print "B"
print "C"
print "\n"   # => ABC  (all on one line, newline added manually)

# p — prints the inspect representation; great for debugging
p "Hello from p"     # => "Hello from p"   (quotes visible)
p 42                 # => 42
p nil                # => nil
p [1, 2, 3]          # => [1, 2, 3]        (array on one line)

puts "--- puts with an Array ---"
puts [1, 2, 3]   # each element on its own line, no brackets
# 1
# 2
# 3

puts "=" * 50
puts "EXAMPLE 2: String Interpolation"
puts "=" * 50

name = "Alice"
age  = 30
city = "Wonderland"

# Basic variable interpolation
puts "My name is #{name}."                      # My name is Alice.
puts "I am #{age} years old."                   # I am 30 years old.
puts "I live in #{city}."                       # I live in Wonderland.

# Expression inside interpolation
puts "Next year I will be #{age + 1}."          # Next year I will be 31.
puts "Name in caps: #{name.upcase}."            # Name in caps: ALICE.
puts "#{3 > 2 ? 'Three wins' : 'Two wins'}!"   # Three wins!

# Interpolation with multiple variables in one string
puts "#{name} is #{age} and lives in #{city}."
# Alice is 30 and lives in Wonderland.

# Single quotes do NOT interpolate — this is a common mistake
puts 'Hello, #{name}!'   # Hello, #{name}!  — literal, not replaced

puts "=" * 50
puts "EXAMPLE 3: Running .rb Files from the Terminal"
puts "=" * 50

# You are running this file right now with:
#   ruby examples.rb
#
# Other ways to run Ruby code:
#   ruby -e 'puts "one-liner"'   — run a string as a Ruby program
#   ruby -w examples.rb          — run with warnings enabled
#
# The exit status of a Ruby program:
#   $? in the shell — 0 means success, non-zero means error

puts "This file was started at: #{Time.now}"
puts "Ruby version: #{RUBY_VERSION}"

puts "=" * 50
puts "EXAMPLE 4: IRB Basics"
puts "=" * 50

# IRB (Interactive Ruby) is a REPL — Read-Eval-Print Loop.
# Start it from your terminal:  irb
# Each expression you type is evaluated and the result shown with =>

# These are the kinds of things you'd try in IRB:
expressions = [
  "2 + 2",
  '"hello".upcase',
  "[1, 2, 3].sum",
  '"ruby".reverse',
  "(1..5).to_a"
]

expressions.each do |expr|
  result = eval(expr) # rubocop:disable Security/Eval
  puts "irb> #{expr}"
  puts "  => #{result.inspect}"
end
# irb> 2 + 2
#   => 4
# irb> "hello".upcase
#   => "HELLO"
# (etc.)

puts "=" * 50
puts "EXAMPLE 5: Comments"
puts "=" * 50

# Single-line comment: everything after # is ignored
x = 10   # x stores the score; it's an Integer

# Comments can appear on their own line
# or after code on the same line (inline comments)

# Multi-line comments are just consecutive # lines:
# Step 1: get the user's name
# Step 2: print a greeting
# Step 3: done

greeting = "Hello"   # assigned once; never changes in this example
puts greeting        # Hello

# Temporarily disable code by commenting it out:
# puts "This line is disabled and won't run"
puts "This line runs normally"

puts "=" * 50
puts "EXAMPLE 6: p vs puts — inspect strings"
puts "=" * 50

tab_str    = "line1\tline2"
newline_str = "line1\nline2"

puts "puts tab_str:"
puts tab_str         # line1	line2  (tab rendered)

puts "p tab_str:"
p tab_str            # "line1\tline2"  (escape shown)

puts "puts newline_str:"
puts newline_str     # two separate lines
# line1
# line2

puts "p newline_str:"
p newline_str        # "line1\nline2"  (escape shown)

# ============================================================
# End of examples — run with:  ruby examples.rb
# ============================================================
