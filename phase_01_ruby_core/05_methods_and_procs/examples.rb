# frozen_string_literal: true

# ============================================================
# Lesson 05 — Methods, Procs, and Lambdas
# examples.rb — Complete runnable examples
# ============================================================
# Run with:  ruby examples.rb
# ============================================================

puts "=" * 60
puts "LESSON 05: Methods, Procs, and Lambdas"
puts "=" * 60

# ------------------------------------------------------------
# 1. Method Definitions
# ------------------------------------------------------------
puts "\n--- 1. Method Definitions ---"

def add(a, b)
  a + b
end
puts add(3, 4)   # => 7

# Default arguments
def greet(name, greeting: "Hello")
  "#{greeting}, #{name}!"
end
puts greet("Alice")                    # => Hello, Alice!
puts greet("Bob", greeting: "Hi")     # => Hi, Bob!

# Implicit return — Ruby returns the last expression
def square(n)
  n * n
end
puts square(9)   # => 81

# Predicate methods (return true/false) end with ?
def even?(n) = n % 2 == 0
puts even?(4)    # => true
puts even?(7)    # => false

# Bang methods (modify in place) end with !
def shout!(str)
  str.upcase!
  str
end
word = +"quiet"  # +str creates an unfrozen (mutable) copy
shout!(word)
puts word        # => QUIET

# ------------------------------------------------------------
# 2. Splat and Double-Splat
# ------------------------------------------------------------
puts "\n--- 2. Splat Arguments ---"

def sum(*numbers)
  numbers.sum
end
puts sum(1, 2, 3)          # => 6
puts sum(10, 20, 30, 40)   # => 100

def introduce(name, **traits)
  trait_list = traits.map { |k, v| "#{k}: #{v}" }.join(", ")
  "#{name} (#{trait_list})"
end
puts introduce("Alice", age: 30, role: "Engineer")
# => Alice (age: 30, role: Engineer)

# ------------------------------------------------------------
# 3. Procs
# ------------------------------------------------------------
puts "\n--- 3. Procs ---"

double = Proc.new { |n| n * 2 }
puts double.call(5)    # => 10
puts double.(6)        # => 12  (alternate call syntax)
puts double[7]         # => 14  (another alternate)

# Procs are lenient with argument count
flexible = Proc.new { |a, b| "a=#{a}, b=#{b}" }
puts flexible.call(1)       # => a=1, b=   (b is nil)
puts flexible.call(1, 2, 3) # => a=1, b=2  (extra arg ignored)

# Storing and reusing proc logic
is_positive = Proc.new { |n| n > 0 }
numbers = [-3, -1, 0, 2, 5]
puts numbers.select(&is_positive).inspect   # => [2, 5]

# ------------------------------------------------------------
# 4. Lambdas
# ------------------------------------------------------------
puts "\n--- 4. Lambdas ---"

multiply = lambda { |a, b| a * b }
puts multiply.call(3, 4)    # => 12

# Arrow (stabby) lambda syntax
divide = ->(a, b) { a.to_f / b }
puts divide.call(10, 3).round(2)   # => 3.33

# Lambda is strict about argument count
strict = ->(x, y) { x + y }
begin
  strict.call(1)
rescue ArgumentError => e
  puts "Lambda error: #{e.message}"
  # => Lambda error: wrong number of arguments (given 1, expected 2)
end

# Lambda return is local; Proc return exits the enclosing method
def proc_return_demo
  p = Proc.new { return "from proc" }
  p.call
  "after proc"   # NEVER reached
end

def lambda_return_demo
  l = lambda { return "from lambda" }
  l.call
  "after lambda"   # IS reached
end

puts proc_return_demo    # => from proc
puts lambda_return_demo  # => after lambda

# ------------------------------------------------------------
# 5. Yield and Blocks
# ------------------------------------------------------------
puts "\n--- 5. Yield and Blocks ---"

def wrap(label)
  puts "[#{label}] START"
  result = yield if block_given?
  puts "[#{label}] END"
  result
end

output = wrap("demo") { "block result" }
puts "Result: #{output}"

# Yielding with arguments
def transform(value)
  yield(value)
end
puts transform(5) { |n| n ** 2 }   # => 25

# Explicit block parameter with &block
def capture(&block)
  puts "Got a block: #{block.class}"
  block.call(10)
end
capture { |n| puts "Block ran with #{n}" }

# ------------------------------------------------------------
# 6. Method Objects and Symbol#to_proc
# ------------------------------------------------------------
puts "\n--- 6. Method Objects & Symbol#to_proc ---"

def cube(n) = n ** 3

# Convert a method to a Proc with method()
cuber = method(:cube)
puts [1, 2, 3, 4].map(&cuber).inspect   # => [1, 8, 27, 64]

# Symbol#to_proc — &:method_name calls that method on each element
words = ["hello", "world", "ruby"]
puts words.map(&:upcase).inspect    # => ["HELLO", "WORLD", "RUBY"]
puts words.map(&:length).inspect    # => [5, 5, 4]
puts words.select(&:frozen?).inspect # => []  (strings aren't frozen here)

# ------------------------------------------------------------
# 7. Closures — Procs capture their surrounding variables
# ------------------------------------------------------------
puts "\n--- 7. Closures ---"

def make_counter(start: 0)
  count = start
  incrementer = -> { count += 1; count }
  resetter    = -> { count = start; count }
  [incrementer, resetter]
end

inc, reset = make_counter(start: 10)
puts inc.call    # => 11
puts inc.call    # => 12
puts inc.call    # => 13
puts reset.call  # => 10

# ------------------------------------------------------------
# 8. Real-World Pattern — Pipeline
# ------------------------------------------------------------
puts "\n--- 8. Real-World: Lambda Pipeline ---"

def pipeline(value, *steps)
  steps.reduce(value) { |result, step| step.call(result) }
end

strip   = ->(s) { s.strip }
upcase  = ->(s) { s.upcase }
exclaim = ->(s) { "#{s}!" }

result = pipeline("  hello world  ", strip, upcase, exclaim)
puts result   # => HELLO WORLD!

# Data transformation pipeline
normalize  = ->(n) { n.to_f }
scale      = ->(n) { n / 100.0 }
round_two  = ->(n) { n.round(2) }

price = pipeline("1299", normalize, scale, round_two)
puts price   # => 12.99

puts "\n" + "=" * 60
puts "All examples complete!"
puts "=" * 60
