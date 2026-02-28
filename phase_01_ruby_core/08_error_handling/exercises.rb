# frozen_string_literal: true

# ============================================================
# Lesson 08 — Error Handling
# exercises.rb — Guided exercises with hints
# ============================================================
# Complete each exercise then run:
#   bundle exec rspec test_lesson.rb
# ============================================================

# ------------------------------------------------------------
# Exercise 1: Custom exception class
# ------------------------------------------------------------
# Define a class `ValidationError` that:
# - Inherits from StandardError
# - Has an attr_reader :field
# - Accepts (message, field: nil) in initialize
#   and calls super(message) to set the message
#
# Hint: class ValidationError < StandardError
#         attr_reader :field
#         def initialize(message, field: nil)
#           super(message)
#           @field = field
#         end
#       end

class ValidationError < StandardError
  # TODO: add attr_reader :field and customize initialize
end

# ------------------------------------------------------------
# Exercise 2: validate_age
# ------------------------------------------------------------
# Write a method `validate_age(age)` that:
# - Raises ValidationError with field: :age if age is not an Integer
#   Message: "must be an Integer"
# - Raises ValidationError with field: :age if age < 0
#   Message: "must be non-negative"
# - Raises ValidationError with field: :age if age > 150
#   Message: "is unrealistically large"
# - Returns true for valid ages
#
# Hint: is_a?(Integer) checks the type
# Hint: raise ValidationError.new("message", field: :age)

def validate_age(age)
  # TODO: implement all three validations
end

# ------------------------------------------------------------
# Exercise 3: safe_fetch
# ------------------------------------------------------------
# Write a method `safe_fetch(hash, key, default: nil)` that:
# - Returns the value for key in hash if it exists
# - Returns default if the key is missing (no error raised)
# - Uses hash.fetch internally (which raises KeyError on miss)
# - Hint: rescue KeyError and return default

def safe_fetch(hash, key, default: nil)
  # TODO: use hash.fetch and rescue KeyError
end

# ------------------------------------------------------------
# Exercise 4: with_retry
# ------------------------------------------------------------
# Write a method `with_retry(max_retries:, &block)` that:
# - Calls the block
# - If RuntimeError is raised, retries up to max_retries times
# - After max_retries exhausted, re-raises the last error
# - Returns the block's return value on success
#
# Hint: Track attempts with a counter variable
# Hint: Use the `retry` keyword inside rescue
# Hint:
#   attempts = 0
#   begin
#     block.call
#   rescue RuntimeError => e
#     attempts += 1
#     retry if attempts <= max_retries
#     raise
#   end

def with_retry(max_retries:, &block)
  # TODO: implement retry logic
end

# ------------------------------------------------------------
# Exercise 5: open_resource (ensure)
# ------------------------------------------------------------
# Write a method `open_resource(name)` that:
# - Takes a name (String) and a block
# - Yields to the block
# - Always "closes" the resource by appending the name to a
#   module-level array called `CLOSED_RESOURCES`
# - Uses ensure so the close happens even if the block raises
#
# We use an array instead of puts so tests can verify it ran.

CLOSED_RESOURCES = []

def open_resource(name)
  # TODO: yield and ensure CLOSED_RESOURCES << name
end

# ------------------------------------------------------------
# Exercise 6: Result class
# ------------------------------------------------------------
# Implement the `Result` class:
# - Result.ok(value) — creates a success result
# - Result.err(message) — creates a failure result
# - #ok? returns true for success, false for failure
# - #error? returns true for failure
# - #value returns the wrapped value (nil for errors)
# - #error returns the error message (nil for successes)
# - #map — if ok?, yields value to block and wraps in Result.ok
#          if error?, returns self unchanged
#
# Hint:
#   class Result
#     attr_reader :value, :error
#     def initialize(value: nil, error: nil)
#       @value = value
#       @error = error
#     end
#     def self.ok(v)   = new(value: v)
#     def self.err(m)  = new(error: m)
#     def ok?    = @error.nil?
#     def error? = !ok?
#     def map
#       ok? ? Result.ok(yield(value)) : self
#     end
#   end

class Result
  attr_reader :value, :error

  def initialize(value: nil, error: nil)
    @value = value
    @error = error
  end

  def self.ok(val)
    # TODO: return a new Result wrapping val as a success
  end

  def self.err(message)
    # TODO: return a new Result wrapping message as a failure
  end

  def ok?
    # TODO: return true if this is a success result
  end

  def error?
    # TODO: return true if this is a failure result
  end

  def map
    # TODO: if ok?, yield value and wrap in Result.ok
    #       if error?, return self unchanged
  end
end
