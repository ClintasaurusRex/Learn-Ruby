# frozen_string_literal: true

# ============================================================
# Lesson 02 — Strings and Symbols
# exercises.rb — Guided exercises with hints
# ============================================================
# Complete each exercise. The test_lesson.rb file will verify
# your solutions automatically.
# Run tests with:  bundle exec rspec test_lesson.rb
# ============================================================

# ------------------------------------------------------------
# Exercise 1: shout
# ------------------------------------------------------------
# Write a method `shout` that takes a string and returns it
# upcased with "!" appended.
#
# Example:
#   shout("hello")         # => "HELLO!"
#   shout("ruby is great") # => "RUBY IS GREAT!"
#
# Hint: Use .upcase on the string, then append "!" with string
#       concatenation or interpolation.
# Hint: str.upcase + "!"  or  "#{str.upcase}!"

def shout(str)
  # TODO: return str upcased with "!" at the end
  # Hint: str.upcase + "!"
end

# ------------------------------------------------------------
# Exercise 2: titleize
# ------------------------------------------------------------
# Write a method `titleize` that capitalizes the first letter
# of each word in a string (title case).
#
# Example:
#   titleize("hello world")         # => "Hello World"
#   titleize("the quick brown fox") # => "The Quick Brown Fox"
#
# Hint: Split the string into words with .split
# Hint: Use .map(&:capitalize) to capitalize each word
# Hint: Join the words back with .join(" ")

def titleize(str)
  # TODO: split → capitalize each word → join back
  # Hint: str.split.map(&:capitalize).join(" ")
end

# ------------------------------------------------------------
# Exercise 3: palindrome?
# ------------------------------------------------------------
# Write a method `palindrome?` that returns true if a string
# reads the same forwards and backwards (ignore case and
# leading/trailing spaces).
#
# Example:
#   palindrome?("racecar")   # => true
#   palindrome?("Madam")     # => true
#   palindrome?("  level ") # => true
#   palindrome?("hello")     # => false
#
# Hint: First normalize: str.downcase.strip
# Hint: Then compare the normalized string to its .reverse

def palindrome?(str)
  # TODO: normalize (downcase + strip) then check if equal to reverse
  # Hint: normalized = str.downcase.strip
  #       normalized == normalized.reverse
end

# ------------------------------------------------------------
# Exercise 4: string_stats
# ------------------------------------------------------------
# Write a method `string_stats` that takes a string and
# returns a Hash with the following keys:
#   :length    => total character count (Integer)
#   :words     => number of words (Integer)
#   :uppercase => the string fully upcased (String)
#   :reversed  => the string reversed (String)
#
# Example:
#   string_stats("hello world")
#   # => { length: 11, words: 2, uppercase: "HELLO WORLD", reversed: "dlrow olleh" }
#
# Hint: Use .length for character count
# Hint: Use .split.length for word count
# Hint: Use .upcase for the uppercase version
# Hint: Use .reverse for the reversed version

def string_stats(str)
  # TODO: return a hash with :length, :words, :uppercase, :reversed
  # Hint: {
  #   length:    str.length,
  #   words:     str.split.length,
  #   uppercase: str.upcase,
  #   reversed:  str.reverse
  # }
end

# ------------------------------------------------------------
# Exercise 5: symbol_to_strings
# ------------------------------------------------------------
# Write a method `symbol_to_strings` that takes an array of
# symbols and returns an array of strings.
#
# Example:
#   symbol_to_strings([:hello, :world])   # => ["hello", "world"]
#   symbol_to_strings([:name, :age])      # => ["name", "age"]
#
# Hint: Use .map(&:to_s) — this uses Symbol#to_proc
# Hint: Each symbol responds to .to_s which returns its string form

def symbol_to_strings(arr_of_symbols)
  # TODO: map each symbol to its string form using &:to_s
  # Hint: arr_of_symbols.map(&:to_s)
end

# ------------------------------------------------------------
# Exercise 6: apply_transform
# ------------------------------------------------------------
# Write a method `apply_transform` that takes an array of strings
# and a symbol (like :upcase, :downcase, or :reverse), and
# returns a new array with that method applied to each string
# using Symbol#to_proc.
#
# Example:
#   apply_transform(["hello", "world"], :upcase)
#   # => ["HELLO", "WORLD"]
#
#   apply_transform(["Hello", "World"], :downcase)
#   # => ["hello", "world"]
#
#   apply_transform(["abc", "xyz"], :reverse)
#   # => ["cba", "zyx"]
#
# Hint: Use arr.map(&transform_sym)
# Hint: The & operator converts a symbol to a Proc block

def apply_transform(arr, transform_sym)
  # TODO: apply the symbol as a method to each element using &transform_sym
  # Hint: arr.map(&transform_sym)
end
