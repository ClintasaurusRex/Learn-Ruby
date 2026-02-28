# frozen_string_literal: true

# ============================================================
# Lesson 08 — Error Handling
# examples.rb — Complete runnable examples
# ============================================================
# Run with:  ruby examples.rb
# ============================================================

puts "=" * 60
puts "LESSON 08: Error Handling"
puts "=" * 60

# ------------------------------------------------------------
# 1. Basic begin/rescue/end
# ------------------------------------------------------------
puts "\n--- 1. Basic rescue ---"

begin
  puts 10 / 0
rescue ZeroDivisionError => e
  puts "Caught ZeroDivisionError: #{e.message}"
end
# => Caught ZeroDivisionError: divided by 0

begin
  Integer("not_a_number")
rescue ArgumentError => e
  puts "Caught ArgumentError: #{e.message}"
end
# => Caught ArgumentError: invalid value for Integer(): "not_a_number"

# ------------------------------------------------------------
# 2. raise
# ------------------------------------------------------------
puts "\n--- 2. raise ---"

def positive_only(n)
  raise ArgumentError, "#{n} must be positive" unless n > 0
  n
end

begin
  puts positive_only(5)    # => 5
  puts positive_only(-1)
rescue ArgumentError => e
  puts "Error: #{e.message}"   # => Error: -1 must be positive
end

# raise with no args re-raises inside rescue
def risky
  raise "initial error"
rescue => e
  puts "Logging: #{e.message}"
  raise   # re-raise the same error
end

begin
  risky
rescue => e
  puts "Outer caught: #{e.message}"
end

# ------------------------------------------------------------
# 3. ensure
# ------------------------------------------------------------
puts "\n--- 3. ensure ---"

def with_log(label)
  puts "[START] #{label}"
  result = yield
  puts "[END] #{label} succeeded"
  result
rescue => e
  puts "[END] #{label} failed: #{e.message}"
  nil
ensure
  puts "[ALWAYS] #{label} cleanup"
end

with_log("Task A") { 42 }
with_log("Task B") { raise "oops" }

# ------------------------------------------------------------
# 4. Multiple rescue clauses
# ------------------------------------------------------------
puts "\n--- 4. Multiple rescue ---"

def process(input)
  raise TypeError, "need a String" unless input.is_a?(String)
  raise ArgumentError, "empty string" if input.empty?
  Integer(input)
end

["42", "", "abc", nil].each do |val|
  begin
    result = process(val)
    puts "OK: #{result}"
  rescue TypeError => e
    puts "TYPE: #{e.message}"
  rescue ArgumentError => e
    puts "ARG: #{e.message}"
  end
end

# ------------------------------------------------------------
# 5. Custom Exception Classes
# ------------------------------------------------------------
puts "\n--- 5. Custom Exceptions ---"

class AppError < StandardError; end

class ValidationError < AppError
  attr_reader :field

  def initialize(message, field: nil)
    super(message)
    @field = field
  end
end

class AuthorizationError < AppError
  def initialize(action, resource)
    super("Not allowed to #{action} #{resource}")
  end
end

def validate_email(email)
  raise ValidationError.new("Email is blank", field: :email) if email.to_s.empty?
  raise ValidationError.new("Email missing @", field: :email) unless email.include?("@")
  true
end

begin
  validate_email("notanemail")
rescue ValidationError => e
  puts "Validation failed on #{e.field}: #{e.message}"
end

begin
  raise AuthorizationError.new("delete", "User #42")
rescue AuthorizationError => e
  puts e.message
end

# Catching the parent catches all children
begin
  validate_email("")
rescue AppError => e
  puts "Caught AppError (parent): #{e.class} — #{e.message}"
end

# ------------------------------------------------------------
# 6. retry
# ------------------------------------------------------------
puts "\n--- 6. retry ---"

def flaky_operation(fail_times)
  attempts = 0
  begin
    attempts += 1
    raise "Temporary failure" if attempts <= fail_times
    "Success on attempt #{attempts}"
  rescue RuntimeError => e
    puts "  Attempt #{attempts} failed: #{e.message}"
    retry if attempts <= fail_times
    raise
  end
end

puts flaky_operation(2)   # fails twice, succeeds on 3rd

# Retry with max limit
def with_retry(max:)
  attempts = 0
  begin
    yield
  rescue => e
    attempts += 1
    puts "  Retry #{attempts}..."
    retry if attempts < max
    raise
  end
end

begin
  with_retry(max: 3) do
    raise "Always fails"
  end
rescue => e
  puts "Gave up: #{e.message}"
end

# ------------------------------------------------------------
# 7. Exception information
# ------------------------------------------------------------
puts "\n--- 7. Exception info ---"

begin
  nil.upcase
rescue => e
  puts "Class:   #{e.class}"
  puts "Message: #{e.message}"
  puts "Backtrace (first line): #{e.backtrace.first}"
end

# ------------------------------------------------------------
# 8. Result pattern (avoid exceptions for expected failures)
# ------------------------------------------------------------
puts "\n--- 8. Result pattern ---"

class Result
  attr_reader :value, :error

  def initialize(value: nil, error: nil)
    @value = value
    @error = error
  end

  def self.ok(value)  = new(value: value)
  def self.err(msg)   = new(error: msg)

  def ok?    = @error.nil?
  def error? = !ok?

  def map
    ok? ? Result.ok(yield(value)) : self
  end

  def to_s
    ok? ? "Ok(#{value})" : "Err(#{error})"
  end
end

def safe_divide(a, b)
  return Result.err("division by zero") if b == 0
  Result.ok(a.to_f / b)
end

puts safe_divide(10, 2).map { |v| v * 100 }  # => Ok(500.0)
puts safe_divide(10, 0)                        # => Err(division by zero)

puts "\n" + "=" * 60
puts "All examples complete!"
puts "=" * 60
