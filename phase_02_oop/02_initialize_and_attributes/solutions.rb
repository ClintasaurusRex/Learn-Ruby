# frozen_string_literal: true

# Exercise 1 solution:
# initialize is where an object receives its first state values.
def initialize_phrase
  "initialize sets state"
end

# Exercise 2 solution:
# Simple formatter for an attribute-like value.
def format_title(title)
  "Book(#{title})"
end

# Exercise 3 solution:
# Positive page counts are a basic validity check.
def positive_pages?(pages)
  pages.positive?
end

# Exercise 4 solution:
# Pair values together to represent current object state.
def state_pair(title, pages)
  [title, pages]
end

# Exercise 5 solution:
# Build a readable sentence from attributes.
def pages_label(title, pages)
  "#{title} has #{pages} pages"
end

puts initialize_phrase
puts format_title("Ruby")
puts positive_pages?(10)
p state_pair("Ruby", 300)
puts pages_label("Ruby", 300)
