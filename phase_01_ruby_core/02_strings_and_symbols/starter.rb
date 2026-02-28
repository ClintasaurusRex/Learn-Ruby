# frozen_string_literal: true

# ============================================================
# Lesson 02 — Strings and Symbols
# starter.rb — Working starter code with TODOs and Hints
# ============================================================
# Run this file with:  ruby starter.rb
# ============================================================

# ------------------------------------------------------------
# PART 1: Core String Methods
# ------------------------------------------------------------

message = "  Hello, Ruby World!  "

# These already work — study them, then answer the TODOs below
puts message.strip                        # => "Hello, Ruby World!"
puts message.strip.downcase               # => "hello, ruby world!"
puts message.strip.upcase                 # => "HELLO, RUBY WORLD!"
puts message.include?("Ruby")             # => true
puts message.strip.start_with?("Hello")   # => true
puts message.strip.length                 # => 19

# TODO: Print the message with "Ruby" replaced by "Crystal"
# Hint: Use .gsub("old", "new") — returns a new string
# puts message.strip.gsub(...)

# TODO: Split the stripped message on ", " and print the resulting array
# Hint: "a, b".split(", ") => ["a", "b"]
# puts message.strip.split(", ").inspect

# TODO: Print the message reversed (strip it first)
# Hint: .reverse returns a new reversed string
# puts message.strip.reverse

# ------------------------------------------------------------
# PART 2: String Formatting
# ------------------------------------------------------------

title = "ruby"

# Already works — study the pattern
puts title.capitalize        # => "Ruby"
puts title.center(20, "=")  # => "========ruby========"
puts title.ljust(20, ".")   # => "ruby................"
puts title.rjust(20, ".")   # => "................ruby"

# TODO: Print `title` upcased and centered in 20 chars with "-" padding
# Hint: Chain .upcase and .center(20, "-")
# puts title...

# TODO: Use string interpolation to print: "The title is: ruby (length: 4)"
# Hint: "The title is: #{title} (length: #{title.length})"
# puts "..."

# ------------------------------------------------------------
# PART 3: More Useful String Methods
# ------------------------------------------------------------

sentence = "the quick brown fox jumps over the lazy dog"

# Count occurrences of "the"
puts sentence.scan("the").length   # => 2

# Get characters at specific positions
puts sentence[4..8]                # => "quick"
puts sentence.chars.first(5).inspect # => ["t", "h", "e", " ", "q"]

# TODO: Count how many vowels are in `sentence`
# Hint: sentence.chars.select { |c| "aeiou".include?(c) }.length
# puts "Vowels: #{...}"

# TODO: Print each word in `sentence` capitalized (title-cased)
# Hint: sentence.split.map(&:capitalize).join(" ")
# puts ...

# TODO: Check if "fox" appears in `sentence` and print true or false
# Hint: Use .include?
# puts sentence.include?(...)

# ------------------------------------------------------------
# PART 4: Heredocs
# ------------------------------------------------------------

# Squiggly heredoc (<<~) strips leading whitespace automatically
# This already works — observe the indentation behavior
puts <<~WELCOME
  Welcome to the Strings and Symbols lesson!
  Heredocs are great for multi-line text.
  The <<~ prefix strips leading whitespace.
WELCOME

# TODO: Write your own heredoc that prints a 3-line address:
#   123 Main St
#   Springfield, IL 62701
#   USA
# Hint: puts <<~ADDRESS
#          ...
#        ADDRESS

# ------------------------------------------------------------
# PART 5: Symbols vs Strings
# ------------------------------------------------------------

# Already works — study the differences
lang_string = "ruby"
lang_symbol = :ruby

puts lang_string.class   # => String
puts lang_symbol.class   # => Symbol
puts lang_string == lang_symbol   # => false (different types!)

# Convert between them
puts lang_symbol.to_s.class   # => String
puts lang_string.to_sym.class # => Symbol

# Symbols are the same object in memory
puts :ruby.equal?(:ruby)           # => true  (same object)
puts "ruby".equal?("ruby")         # => false (different objects)

# Symbols as hash keys (idiomatic Ruby)
user = { name: "Alice", role: :admin, age: 30 }
puts user[:name]    # => Alice
puts user[:role]    # => admin

# TODO: Add a :language key to `user` with value :ruby and print it
# Hint: user = user.merge(language: :ruby)  or just add it above
# puts user[:language]

# ------------------------------------------------------------
# PART 6: Symbol#to_proc  (&:method_name pattern)
# ------------------------------------------------------------

words = ["hello", "world", "ruby", "programming"]

# Already works — &:method converts a symbol to a block
puts words.map(&:upcase).inspect      # => ["HELLO", "WORLD", "RUBY", "PROGRAMMING"]
puts words.map(&:length).inspect      # => [5, 5, 4, 11]
puts words.map(&:reverse).inspect     # => ["olleh", "dlrow", "ybur", "gnimmargorp"]
puts words.select(&:frozen?).inspect  # => []

# TODO: Use map(&:capitalize) to capitalize every word and print the result
# puts words.map(...).inspect

# TODO: Use map(&:chars) to turn each word into an array of characters
#       and print the result
# Hint: Each word becomes an array, so you get an array of arrays
# puts words.map(...).inspect

# TODO: Chain methods: downcase each word, then reverse the whole array
# Hint: words.map(&:downcase).reverse
# puts ...

# ============================================================
# Run this file:  ruby starter.rb
# Complete the TODOs — when done, all output should match
# the comments showing expected values.
# ============================================================
