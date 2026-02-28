# Ruby Core Quick Reference ⚡

> Scannable in 60 seconds. Organized by use case.

---

## Strings

```ruby
# Create
s = "hello"
s = 'literal'          # no interpolation
s = "Hello, #{name}"   # interpolation

# Common methods
s.upcase               # "HELLO"
s.downcase             # "hello"
s.capitalize           # "Hello"
s.reverse              # "olleh"
s.length / s.size      # 5
s.strip                # remove leading/trailing whitespace
s.chomp                # remove trailing newline
s.split(" ")           # ["hello"]
s.split(",", 2)        # split with limit
s.include?("ell")      # true
s.start_with?("he")    # true
s.end_with?("lo")      # true
s.gsub("l", "r")       # "herro"
s.sub("l", "r")        # "herlo"  (first only)
s.tr("aeiou", "*")     # "h*ll*"
s.chars                # ["h","e","l","l","o"]
s.bytes                # byte array
s * 3                  # "hellohellohello"
s[0]                   # "h"
s[1..3]                # "ell"
s[-1]                  # "o"
"%s is %d" % ["age", 30]  # "age is 30"
```

---

## Arrays

```ruby
# Create
arr = [1, 2, 3]
arr = Array.new(3, 0)   # [0, 0, 0]
arr = Array.new(3) { |i| i * 2 }  # [0, 2, 4]

# Access
arr[0]          # 1  (first)
arr[-1]         # 3  (last)
arr[1..2]       # [2, 3]
arr.first       # 1
arr.last        # 3
arr.first(2)    # [1, 2]

# Add / Remove
arr.push(4)     # [1,2,3,4]
arr << 4        # same as push
arr.pop         # removes and returns last
arr.unshift(0)  # prepend: [0,1,2,3]
arr.shift       # removes and returns first
arr.insert(1, 99)  # insert at index 1

# Modify
arr.flatten        # flatten nested arrays
arr.compact        # remove nils
arr.uniq           # remove duplicates
arr.sort           # sort ascending
arr.sort_by { |x| x.name }
arr.reverse        # reverse order
arr.shuffle        # random order
arr.sample         # random element
arr.flatten!       # in-place version (modifies arr)

# Query
arr.include?(2)    # true
arr.count          # 3
arr.empty?         # false
arr.any? { |n| n > 2 }    # true
arr.all? { |n| n > 0 }    # true
arr.none? { |n| n < 0 }   # true
arr.min / arr.max
arr.sum
arr.first(2)       # [1, 2]

# Enumerable (the good stuff)
arr.map { |n| n * 2 }           # [2, 4, 6]
arr.select { |n| n.even? }      # [2]
arr.reject { |n| n.even? }      # [1, 3]
arr.find { |n| n > 1 }          # 2
arr.reduce(0) { |sum, n| sum + n }  # 6
arr.reduce(:+)                  # 6
arr.each_with_object([]) { |n, a| a << n * 2 }
arr.flat_map { |n| [n, n * 2] } # [1,2,2,4,3,6]
arr.zip([4,5,6])                # [[1,4],[2,5],[3,6]]
arr.each_slice(2).to_a          # [[1,2],[3]]
arr.each_cons(2).to_a           # [[1,2],[2,3]]
arr.group_by { |n| n.even? }    # {false=>[1,3], true=>[2]}
arr.tally                       # {1=>1, 2=>1, 3=>1}
```

---

## Hashes

```ruby
# Create
h = { name: "Alice", age: 30 }   # symbol keys (preferred)
h = { "name" => "Alice" }        # string keys

# Access
h[:name]              # "Alice"
h.fetch(:name)        # "Alice" (raises if missing)
h.fetch(:name, "default")  # "default" if missing
h.dig(:user, :name)   # safe nested access

# Modify
h[:email] = "alice@example.com"
h.merge({ city: "NY" })    # new hash
h.merge!({ city: "NY" })   # modifies h in place
h.delete(:age)

# Query
h.key?(:name)         # true
h.value?("Alice")     # true
h.keys                # [:name, :age]
h.values              # ["Alice", 30]
h.size / h.length     # 2
h.empty?              # false
h.any? { |k, v| v.is_a?(Integer) }

# Iteration
h.each { |key, val| puts "#{key}: #{val}" }
h.map { |k, v| [k, v.to_s] }.to_h
h.select { |k, v| v.is_a?(String) }
h.reject { |k, v| v.nil? }
h.transform_values { |v| v.to_s }
h.transform_keys { |k| k.to_s }
h.min_by { |k, v| v }
h.group_by { |k, v| v.class }
```

---

## Ranges

```ruby
(1..10)           # inclusive: 1 to 10
(1...10)          # exclusive: 1 to 9
('a'..'z')        # letters
(1..10).to_a      # [1,2,...,10]
(1..10).include?(5)  # true
(1..10).each { |n| puts n }
(1..10).map { |n| n * 2 }
(1..10).select(&:even?)
(1..10).min / (1..10).max
(1..10).sum
(1..10).step(2).to_a  # [1,3,5,7,9]
```

---

## Loops

```ruby
# times
5.times { |i| puts i }          # 0,1,2,3,4

# upto / downto
1.upto(5) { |i| puts i }
5.downto(1) { |i| puts i }

# each
[1,2,3].each { |n| puts n }
{a: 1}.each { |k, v| puts "#{k}=#{v}" }

# while
i = 0
while i < 5
  puts i
  i += 1
end

# until
until i == 5
  i += 1
end

# loop (infinite, use break to exit)
loop do
  break if done?
end

# for (rare in Ruby, prefer each)
for n in 1..5
  puts n
end

# loop control
next if n.even?    # skip to next iteration
break if n > 3     # exit loop
```

---

## Methods

```ruby
# Basic
def greet(name)
  "Hello, #{name}!"
end

# Default argument
def greet(name = "World")
  "Hello, #{name}!"
end

# Keyword arguments
def create_user(name:, age:, admin: false)
  { name: name, age: age, admin: admin }
end
create_user(name: "Alice", age: 30)

# Splat (variable args)
def sum(*numbers)
  numbers.sum
end
sum(1, 2, 3, 4)   # => 10

# Double splat (keyword args as hash)
def log(**options)
  options.each { |k, v| puts "#{k}: #{v}" }
end

# Block argument
def execute(&block)
  block.call
end

# yield
def wrap
  puts "before"
  yield if block_given?
  puts "after"
end

# Return value is implicit (last expression)
def double(n)
  n * 2   # returned automatically
end
```

---

## Blocks, Procs, Lambdas

```ruby
# Block (inline)
[1,2,3].map { |n| n * 2 }
[1,2,3].map do |n|
  n * 2
end

# Proc
double = Proc.new { |n| n * 2 }
double.call(5)   # 10
double.(5)       # 10
double[5]        # 10

# Lambda
double = lambda { |n| n * 2 }
double = ->(n) { n * 2 }       # stabby lambda
double.call(5)   # 10
double.lambda?   # true

# Symbol to proc shorthand
[1,2,3].map(&:to_s)     # ["1","2","3"]
["a","b"].map(&:upcase) # ["A","B"]
```

---

## File I/O

```ruby
# Read entire file
content = File.read("file.txt")

# Read line by line
File.foreach("file.txt") { |line| puts line.chomp }

# Write (overwrites)
File.write("file.txt", "content")

# Append
File.open("file.txt", "a") { |f| f.puts "new line" }

# Read/write (block closes file automatically)
File.open("file.txt", "r") do |f|
  f.each_line { |line| puts line }
end

# CSV
require 'csv'
CSV.foreach("data.csv", headers: true) do |row|
  puts row["name"]
end
CSV.open("out.csv", "w") do |csv|
  csv << ["name", "age"]
  csv << ["Alice", 30]
end

# JSON
require 'json'
data = JSON.parse(File.read("data.json"))
File.write("out.json", JSON.pretty_generate(data))
```

---

## Error Handling

```ruby
# Basic rescue
begin
  result = 10 / 0
rescue ZeroDivisionError => e
  puts "Error: #{e.message}"
end

# Multiple rescue clauses
begin
  risky_operation
rescue ArgumentError => e
  puts "Bad argument: #{e.message}"
rescue StandardError => e
  puts "Error: #{e.message}"
ensure
  cleanup   # always runs
end

# Raise
raise "Something went wrong"
raise ArgumentError, "Invalid input"
raise ArgumentError.new("Invalid input")

# Custom exception
class PaymentError < StandardError
  def initialize(msg = "Payment failed")
    super
  end
end

raise PaymentError
raise PaymentError, "Card declined"

# Retry
attempts = 0
begin
  attempts += 1
  connect_to_api
rescue NetworkError
  retry if attempts < 3
  raise
end
```
