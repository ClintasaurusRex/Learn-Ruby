# frozen_string_literal: true

# ============================================================
# Lesson 08 — Error Handling
# starter.rb — Working starter code with TODOs and Hints
# ============================================================
# Run this file with:  ruby starter.rb
# ============================================================

# ------------------------------------------------------------
# PART 1: Basic begin/rescue/ensure
# ------------------------------------------------------------

# Already works — study this pattern
def divide(a, b)
  raise ArgumentError, "b cannot be zero" if b == 0
  a.to_f / b
end

begin
  puts divide(10, 2)    # => 5.0
  puts divide(10, 0)    # raises ArgumentError
rescue ArgumentError => e
  puts "Caught: #{e.message}"   # => Caught: b cannot be zero
ensure
  puts "Ensure block always runs"
end

# ------------------------------------------------------------
# PART 2: Custom exception class
# ------------------------------------------------------------

# TODO: Define a custom exception class called `ValidationError`
# - It should inherit from StandardError
# - It should optionally accept a :field keyword argument
#   that stores the field name that failed validation
# - Hint: class ValidationError < StandardError
#           attr_reader :field
#           def initialize(message, field: nil)
#             super(message)
#             @field = field
#           end
#         end

class ValidationError < StandardError
  # TODO: add attr_reader :field
  # TODO: customize initialize to accept field: keyword arg
end

# ------------------------------------------------------------
# PART 3: validate_age
# ------------------------------------------------------------

# TODO: Write a method `validate_age(age)` that:
# - Raises ValidationError if age is not an Integer
#   Message: "age must be an Integer"
# - Raises ValidationError if age < 0
#   Message: "age must be positive"
# - Raises ValidationError if age > 150
#   Message: "age is unrealistically large"
# - Returns true if valid
#
# Hint: Use `is_a?(Integer)` to check the type
# Hint: Use raise ValidationError, "message" to raise it

def validate_age(age)
  # TODO: implement validation
end

begin
  validate_age(25)
  puts "25 is valid"
rescue ValidationError => e
  puts "Invalid: #{e.message}"
end

begin
  validate_age(-5)
rescue ValidationError => e
  puts "Invalid: #{e.message}"   # => Invalid: age must be positive
end

begin
  validate_age("old")
rescue ValidationError => e
  puts "Invalid: #{e.message}"   # => Invalid: age must be an Integer
end

# ------------------------------------------------------------
# PART 4: Multiple rescue clauses
# ------------------------------------------------------------

# Already works — study the order of rescue clauses
def parse_number(str)
  raise TypeError, "expected a String" unless str.is_a?(String)
  Integer(str)   # raises ArgumentError if str isn't a valid integer
end

["42", "abc", nil, "7"].each do |input|
  begin
    result = parse_number(input)
    puts "Parsed: #{result}"
  rescue TypeError => e
    puts "Type error: #{e.message}"
  rescue ArgumentError => e
    puts "Parse error for '#{input}': #{e.message}"
  end
end

# ------------------------------------------------------------
# PART 5: retry with limit
# ------------------------------------------------------------

# TODO: Write a method `with_retry(max_retries:, &block)` that:
# - Calls the block
# - If the block raises a RuntimeError, retries up to max_retries times
# - Raises the error after max_retries exhausted
# - Prints "Retry X of Y..." before each retry
#
# Hint: Use `attempts = 0` and `retry` keyword
# Hint:
#   attempts = 0
#   begin
#     block.call
#   rescue RuntimeError => e
#     attempts += 1
#     if attempts <= max_retries
#       puts "Retry #{attempts} of #{max_retries}..."
#       retry
#     end
#     raise
#   end

def with_retry(max_retries:, &block)
  # TODO: implement retry logic
end

call_count = 0
begin
  with_retry(max_retries: 2) do
    call_count += 1
    raise "Flaky failure" if call_count < 3
    puts "Succeeded on attempt #{call_count}"
  end
rescue RuntimeError => e
  puts "Final failure: #{e.message}"
end

# ------------------------------------------------------------
# PART 6: ensure for cleanup
# ------------------------------------------------------------

# TODO: Write a method `open_resource(name)` that:
# - Prints "Opening resource: <name>"
# - Yields to a block
# - Always prints "Closing resource: <name>" in ensure,
#   even if the block raises
#
# Hint: def open_resource(name)
#         puts "Opening resource: #{name}"
#         yield
#       ensure
#         puts "Closing resource: #{name}"
#       end

def open_resource(name)
  # TODO: implement with ensure
end

begin
  open_resource("database") do
    puts "Using the resource"
    raise "Something went wrong"
  end
rescue RuntimeError => e
  puts "Rescued: #{e.message}"
end
# Should print:
# Opening resource: database
# Using the resource
# Closing resource: database  ← ensure ran even after error
# Rescued: Something went wrong

# ============================================================
# Run with:  ruby starter.rb
# ============================================================
