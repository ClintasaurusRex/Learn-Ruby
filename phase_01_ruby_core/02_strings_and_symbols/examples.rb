# frozen_string_literal: true

# ============================================================
# Lesson 02 — Strings and Symbols
# examples.rb — Complete runnable examples
# ============================================================
# Run with:  ruby examples.rb
# ============================================================

puts "=" * 60
puts "LESSON 02: Strings and Symbols"
puts "=" * 60

# ------------------------------------------------------------
# 1. Core String Methods
# ------------------------------------------------------------
puts "\n--- 1. Core String Methods ---"

s = "  Hello, Ruby World!  "

puts s.strip                      # => "Hello, Ruby World!"
puts s.strip.downcase             # => "hello, ruby world!"
puts s.strip.upcase               # => "HELLO, RUBY WORLD!"
puts s.strip.reverse              # => "!dlroW ybuR ,olleH"
puts s.strip.length               # => 19
puts s.strip.include?("Ruby")     # => true
puts s.strip.start_with?("Hello") # => true
puts s.strip.end_with?("!")       # => true
puts s.strip.gsub("Ruby", "Crystal")  # => "Hello, Crystal World!"
puts s.strip.delete("aeiou")      # => "Hll, Rby Wrld!"
puts s.strip.count("l")           # => 3
puts s.strip.index("R")           # => 7

# ------------------------------------------------------------
# 2. String Slicing and Searching
# ------------------------------------------------------------
puts "\n--- 2. Slicing and Searching ---"

text = "Ruby programming is fun"

puts text[0..3]           # => "Ruby"
puts text[5..]            # => "programming is fun"
puts text[-3..]           # => "fun"
puts text.slice(5, 11)    # => "programming"
puts text.scan(/\b\w{3}\b/).inspect  # => ["fun"]  (3-letter words)
puts text.scan(/[aeiou]/).length     # => 7  (vowel count)
puts text.split.inspect              # => ["Ruby", "programming", "is", "fun"]
puts text.split("").first(4).inspect # => ["R", "u", "b", "y"]

# ------------------------------------------------------------
# 3. String Transformation and Formatting
# ------------------------------------------------------------
puts "\n--- 3. Transformation and Formatting ---"

word = "ruby"

puts word.capitalize          # => "Ruby"
puts word.upcase              # => "RUBY"
puts word.center(12, "-")     # => "----ruby----"
puts word.ljust(12, ".")      # => "ruby........"
puts word.rjust(12, ".")      # => "........ruby"

phrase = "the quick brown fox"
puts phrase.split.map(&:capitalize).join(" ")  # => "The Quick Brown Fox"

messy = "   too   many    spaces   "
puts messy.split.join(" ")    # => "too many spaces"

# tr replaces character-by-character
puts "hello".tr("aeiou", "*")      # => "h*ll*"
puts "hello".squeeze("l")          # => "helo"
puts "hello world".delete(" ")     # => "helloworld"

# ------------------------------------------------------------
# 4. String Interpolation and Inspection
# ------------------------------------------------------------
puts "\n--- 4. Interpolation and Inspection ---"

name  = "Alice"
score = 98

# Interpolation — the #{} runs any Ruby expression
puts "Name: #{name}, Score: #{score}, Grade: #{score >= 90 ? "A" : "B"}"
# => Name: Alice, Score: 98, Grade: A

puts "Upcase inline: #{"hello".upcase}"  # => Upcase inline: HELLO
puts "Pi ≈ #{Math::PI.round(4)}"          # => Pi ≈ 3.1416

# .inspect shows the raw string (useful for debugging)
puts "tab:\there".inspect     # => "tab:\there"
puts "newline\nhere".inspect  # => "newline\nhere"

# ------------------------------------------------------------
# 5. Heredocs
# ------------------------------------------------------------
puts "\n--- 5. Heredocs ---"

# <<~HEREDOC strips leading whitespace (squiggly heredoc)
puts <<~POEM
  Roses are red,
  Violets are blue,
  Ruby is elegant,
  And so are you.
POEM

# Heredoc used directly in a method call
formatted_address = [
  "123 Main St",
  "Springfield, IL 62701",
  "USA"
].join("\n")
puts formatted_address

# Heredoc with interpolation
lang    = "Ruby"
version = "3.2"
puts <<~INFO
  Language: #{lang}
  Version:  #{version}
  Released: #{2023}
INFO

# ------------------------------------------------------------
# 6. Symbols vs Strings
# ------------------------------------------------------------
puts "\n--- 6. Symbols vs Strings ---"

# Symbols: immutable, single instance, no methods for manipulation
status = :active
puts status.class          # => Symbol
puts status.to_s           # => "active"
puts status.inspect        # => ":active"
puts :active.equal?(:active)    # => true  (same object)
puts "active".equal?("active")  # => false (different objects)

# Strings: mutable (unless frozen), many methods
greeting = "hello"
puts greeting.class        # => String
puts greeting.to_sym       # => :hello
puts greeting.frozen?      # => true (frozen_string_literal is on)

# Symbols as hash keys (the idiomatic Ruby way)
config = {
  host:     "localhost",
  port:     5432,
  adapter:  :postgresql,
  ssl:      false
}
puts config[:host]     # => localhost
puts config[:adapter]  # => postgresql

# When to use which:
# Symbol  → hash keys, method names, status flags, internal identifiers
# String  → user input, output text, anything that needs transformation

# ------------------------------------------------------------
# 7. Symbol#to_proc — &:method_name pattern
# ------------------------------------------------------------
puts "\n--- 7. Symbol#to_proc (&:method_name) ---"

words = ["hello", "world", "ruby", "programming"]

# &:upcase is shorthand for { |w| w.upcase }
puts words.map(&:upcase).inspect     # => ["HELLO", "WORLD", "RUBY", "PROGRAMMING"]
puts words.map(&:reverse).inspect    # => ["olleh", "dlrow", "ybur", "gnimmargorp"]
puts words.map(&:length).inspect     # => [5, 5, 4, 11]
puts words.map(&:chars).map(&:first).inspect  # => ["h", "w", "r", "p"]

# Works with select/reject too
numbers = [1, 2, 3, 4, 5, 6]
puts numbers.select(&:odd?).inspect   # => [1, 3, 5]
puts numbers.reject(&:even?).inspect  # => [1, 3, 5]

# Symbol array of symbols → strings
symbols = [:name, :age, :email, :role]
puts symbols.map(&:to_s).inspect      # => ["name", "age", "email", "role"]

# What's actually happening under the hood:
# :upcase.to_proc   => Proc that calls .upcase on its argument
# &:upcase          => converts that Proc to a block
upcase_proc = :upcase.to_proc
puts upcase_proc.call("hello")        # => "HELLO"
puts upcase_proc.class                # => Proc

# ------------------------------------------------------------
# 8. Chaining — Real-World Patterns
# ------------------------------------------------------------
puts "\n--- 8. Real-World Chaining Patterns ---"

# Normalize user-submitted tags
raw_tags = ["  Ruby ", "rails", "RUBY", " JavaScript  ", "rails"]
cleaned = raw_tags.map(&:strip).map(&:downcase).uniq.sort
puts cleaned.inspect
# => ["javascript", "rails", "ruby"]

# Build a URL slug from a blog title
title = "  My Awesome Blog Post! (2024)  "
slug  = title.strip.downcase.gsub(/[^a-z0-9]+/, "-").delete_suffix("-").delete_prefix("-")
puts slug
# => "my-awesome-blog-post-2024"

# Extract initials from a full name
full_name = "Alice Marie Wonderland"
initials  = full_name.split.map { |part| part[0] }.join(".")
puts initials
# => "A.M.W"

# Count word frequency in text
sample = "to be or not to be that is the question to be"
freq   = sample.split.tally.sort_by { |_, count| -count }.first(3)
puts freq.map { |word, count| "#{word}:#{count}" }.join(", ")
# => "to:3, be:3, or:1"  (order may vary for ties)

puts "\n" + "=" * 60
puts "All examples complete!"
puts "=" * 60
