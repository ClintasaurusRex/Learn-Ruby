# frozen_string_literal: true

# ============================================================
# Lesson 08 — Error Handling
# solutions.rb — Solutions with plain-language explanations
# ============================================================

# ------------------------------------------------------------
# Exercise 1: ValidationError
# ------------------------------------------------------------
# We inherit from StandardError so rescue StandardError catches it.
# The field: keyword arg lets callers tag which field failed.
# super(message) passes the message up to StandardError#initialize
# so e.message works normally.

class ValidationError < StandardError
  attr_reader :field

  def initialize(message, field: nil)
    super(message)
    @field = field
  end
end

err = ValidationError.new("is required", field: :email)
puts err.message   # => is required
puts err.field     # => email

# ------------------------------------------------------------
# Exercise 2: validate_age
# ------------------------------------------------------------
# We check the most restrictive condition first (type),
# then range conditions. raise exits the method immediately.
# Returning true at the end signals success to the caller.

def validate_age(age)
  raise ValidationError.new("must be an Integer", field: :age) unless age.is_a?(Integer)
  raise ValidationError.new("must be non-negative", field: :age) if age < 0
  raise ValidationError.new("is unrealistically large", field: :age) if age > 150
  true
end

begin
  validate_age(25)
  puts "25 is valid"
rescue ValidationError => e
  puts "#{e.field}: #{e.message}"
end
# => 25 is valid

begin
  validate_age(-1)
rescue ValidationError => e
  puts "#{e.field}: #{e.message}"
end
# => age: must be non-negative

begin
  validate_age("old")
rescue ValidationError => e
  puts "#{e.field}: #{e.message}"
end
# => age: must be an Integer

# ------------------------------------------------------------
# Exercise 3: safe_fetch
# ------------------------------------------------------------
# hash.fetch(key) raises KeyError when key is missing.
# We rescue that and return the default instead.
# This is better than checking hash.key?(key) first —
# it's atomic and works correctly with nil values.

def safe_fetch(hash, key, default: nil)
  hash.fetch(key)
rescue KeyError
  default
end

config = { host: "localhost", port: 5432 }
puts safe_fetch(config, :host)           # => localhost
puts safe_fetch(config, :port)           # => 5432
puts safe_fetch(config, :missing).inspect  # => nil
puts safe_fetch(config, :missing, default: "N/A")  # => N/A

# ------------------------------------------------------------
# Exercise 4: with_retry
# ------------------------------------------------------------
# We track attempts before the begin block so it persists
# across retries (variables inside begin reset on retry).
# After exhausting retries we `raise` with no args to re-raise
# the last error — this preserves the original backtrace.

def with_retry(max_retries:, &block)
  attempts = 0
  begin
    block.call
  rescue RuntimeError => e
    attempts += 1
    retry if attempts <= max_retries
    raise
  end
end

# Succeeds on 3rd try
call_count = 0
result = with_retry(max_retries: 3) do
  call_count += 1
  raise "Not yet" if call_count < 3
  "Done after #{call_count} calls"
end
puts result   # => Done after 3 calls

# Exhausts retries and re-raises
begin
  with_retry(max_retries: 2) { raise "always" }
rescue RuntimeError => e
  puts "Gave up: #{e.message}"   # => Gave up: always
end

# ------------------------------------------------------------
# Exercise 5: open_resource (ensure)
# ------------------------------------------------------------
# ensure runs even when the block raises an error.
# This guarantees the resource is always marked closed,
# which is the same pattern File.open uses internally.

CLOSED_RESOURCES = []

def open_resource(name)
  yield
ensure
  CLOSED_RESOURCES << name
end

open_resource("db") { puts "Using db" }
puts CLOSED_RESOURCES.inspect   # => ["db"]

begin
  open_resource("cache") { raise "Cache error" }
rescue => e
  puts "Caught: #{e.message}"
end
puts CLOSED_RESOURCES.inspect   # => ["db", "cache"]  — ensure ran!

# ------------------------------------------------------------
# Exercise 6: Result class
# ------------------------------------------------------------
# The Result class wraps a value OR an error message.
# ok? and error? let callers check which case they have.
# map lets you transform the value safely — it's a no-op on errors.
# This pattern avoids raising exceptions for *expected* failures
# (like "user not found") while keeping exceptions for
# truly unexpected failures (like database crashes).

class Result
  attr_reader :value, :error

  def initialize(value: nil, error: nil)
    @value = value
    @error = error
  end

  def self.ok(val)      = new(value: val)
  def self.err(message) = new(error: message)

  def ok?    = @error.nil?
  def error? = !ok?

  def map
    ok? ? Result.ok(yield(value)) : self
  end

  def to_s
    ok? ? "Ok(#{value})" : "Err(#{error})"
  end
end

# Usage
success = Result.ok(42)
puts success.ok?         # => true
puts success.value       # => 42
puts success.map { |v| v * 2 }.value  # => 84

failure = Result.err("not found")
puts failure.ok?         # => false
puts failure.error?      # => true
puts failure.error       # => not found
puts failure.map { |v| v * 2 }.error  # => not found (unchanged)
