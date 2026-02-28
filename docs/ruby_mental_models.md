# Ruby Mental Models 🧠

> 7 mental models that help you think like a Rubyist.  
> Read these before struggling. Return to them when confused.

---

## Mental Model 1 — Everything Is an Object

In Ruby, everything is an object with methods. There are no primitives.

```
┌─────────────────────────────────────────────────┐
│              EVERYTHING IS AN OBJECT             │
│                                                  │
│   42           →  Integer object                │
│   "hello"      →  String object                 │
│   [1, 2, 3]    →  Array object                  │
│   true         →  TrueClass object              │
│   nil          →  NilClass object               │
│   :symbol      →  Symbol object                 │
│   { a: 1 }     →  Hash object                   │
│                                                  │
│   Every object has methods. Call them with dot. │
└─────────────────────────────────────────────────┘
```

**Examples:**

```ruby
42.class          # => Integer
42.even?          # => true
42.to_s           # => "42"

"hello".upcase    # => "HELLO"
"hello".length    # => 5
"hello".reverse   # => "olleh"

nil.nil?          # => true
nil.class         # => NilClass

true.class        # => TrueClass
false.class       # => FalseClass
```

**Common mistake:** Trying to call a method on nil will raise `NoMethodError`.

```ruby
user = nil
user.name    # => NoMethodError: undefined method 'name' for nil
user&.name   # => nil  (safe navigation operator — use this)
```

**Debug tip:** When in doubt, call `.class` on anything to see what it is.

---

## Mental Model 2 — Objects and Scope

Variables have scope. Where you define a variable determines where you can use it.

```
┌────────────────────────────────────────────────────┐
│                   SCOPE ZONES                      │
│                                                    │
│  Global: $global_var  ← accessible everywhere     │
│  ┌──────────────────────────────────────────────┐  │
│  │ Class: @@class_var  ← shared by all instances│  │
│  │ ┌────────────────────────────────────────┐   │  │
│  │ │ Instance: @instance_var ← per object  │   │  │
│  │ │ ┌──────────────────────────────────┐  │   │  │
│  │ │ │ Local: local_var ← method only   │  │   │  │
│  │ │ │ ┌────────────────────────────┐   │  │   │  │
│  │ │ │ │ Block: |block_var|         │   │  │   │  │
│  │ │ │ └────────────────────────────┘   │  │   │  │
│  │ │ └──────────────────────────────────┘  │   │  │
│  │ └────────────────────────────────────────┘   │  │
│  └──────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────┘
```

**Examples:**

```ruby
$global = "everyone sees me"    # global (avoid these)

class Dog
  @@count = 0                   # class variable (shared)
  
  def initialize(name)
    @name = name                # instance variable (per dog)
    @@count += 1
    local = "only in this method"  # local variable
  end
  
  def self.count
    @@count
  end
end

fido = Dog.new("Fido")
rex  = Dog.new("Rex")
Dog.count   # => 2
```

**Common mistake:** Block variables are local to the block, but blocks CAN access outer local variables.

```ruby
x = 10
[1, 2, 3].each do |n|
  puts x + n   # ✓ x is accessible (closure)
  y = n * 2    # y is local to this block
end
puts y           # => NameError: undefined local variable 'y'
```

---

## Mental Model 3 — Symbols vs Strings

They look similar but have very different purposes.

```
┌───────────────────────────────────────────────────┐
│              SYMBOLS  vs  STRINGS                 │
│                                                   │
│  :name          "name"                            │
│  ─────────────  ──────────────────────────────   │
│  Immutable      Mutable                          │
│  One in memory  New object each time             │
│  For identity   For text/content                 │
│  Fast to compare Slower to compare               │
│  Hash keys ✓    User input ✓                     │
│  Method names   Display text ✓                   │
│                                                   │
│  :name.object_id == :name.object_id  # always!   │
│  "name".object_id != "name".object_id # different │
└───────────────────────────────────────────────────┘
```

**Examples:**

```ruby
# Symbols as hash keys (most common use)
user = { name: "Alice", age: 30 }
user[:name]   # => "Alice"

# Symbols for method names in metaprogramming
attr_accessor :name, :age

# When to use which
config = { debug: true }        # symbol key ← label/identifier
message = "Hello, #{user[:name]}"  # string ← content

# Convert between them
:hello.to_s    # => "hello"
"hello".to_sym # => :hello
```

---

## Mental Model 4 — Blocks, Procs, and Lambdas

All three are "chunks of code you can pass around," but they behave differently.

```
┌────────────────────────────────────────────────────────┐
│         BLOCKS → PROCS → LAMBDAS                       │
│                                                        │
│  Block: lightweight, anonymous, attached to a method   │
│    { |x| x * 2 }   or   do |x|  x * 2  end            │
│                                                        │
│  Proc: a saved block you can reuse                     │
│    double = Proc.new { |x| x * 2 }                    │
│    double.call(5)   # => 10                            │
│                                                        │
│  Lambda: like Proc but stricter (checks arg count,     │
│          returns only from itself)                     │
│    double = ->(x) { x * 2 }                           │
│    double.call(5)   # => 10                            │
│                                                        │
│  Key differences:                                      │
│    return in Proc  → exits the OUTER method            │
│    return in Lambda → exits only the lambda            │
│    Proc ignores extra args; Lambda raises ArgumentError│
└────────────────────────────────────────────────────────┘
```

**Examples:**

```ruby
# Block (inline)
[1, 2, 3].map { |n| n * 2 }        # => [2, 4, 6]

# Proc (saved block)
double = Proc.new { |n| n * 2 }
[1, 2, 3].map(&double)              # => [2, 4, 6]

# Lambda (strict proc)
double = ->(n) { n * 2 }
double.call(5)                      # => 10
double.(5)                          # => 10 (shorthand)

# yield keyword — call the block passed to a method
def greet
  puts "Before"
  yield("World") if block_given?
  puts "After"
end

greet { |name| puts "Hello, #{name}!" }
# Before
# Hello, World!
# After
```

**Common mistakes:**
- Forgetting `&` when converting a proc to a block: use `map(&my_proc)`
- Using `return` in a Proc inside a method accidentally exits the method

---

## Mental Model 5 — Method Lookup

When you call a method, Ruby searches for it in a specific order.

```
┌──────────────────────────────────────────────────────┐
│              METHOD LOOKUP ORDER                     │
│                                                      │
│  myobj.some_method                                   │
│         ↓                                            │
│  1. Singleton class (just this object)               │
│         ↓                                            │
│  2. myobj's class (e.g., Dog)                        │
│         ↓                                            │
│  3. Modules included in class (last included first)  │
│         ↓                                            │
│  4. Superclass (e.g., Animal)                        │
│         ↓                                            │
│  5. Modules in superclass                            │
│         ↓                                            │
│  6. Object → Kernel → BasicObject                   │
│         ↓                                            │
│  7. method_missing (if defined)                      │
│         ↓                                            │
│  8. NoMethodError raised                             │
└──────────────────────────────────────────────────────┘
```

**Examples:**

```ruby
module Swimmable
  def swim
    "#{name} is swimming"
  end
end

module Flyable
  def fly
    "#{name} is flying"
  end
end

class Animal
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Duck < Animal
  include Swimmable
  include Flyable
end

donald = Duck.new("Donald")
donald.swim   # => "Donald is swimming"
donald.fly    # => "Donald is flying"

# Check the lookup path
Duck.ancestors
# => [Duck, Flyable, Swimmable, Animal, Object, Kernel, BasicObject]
```

**Debug tip:** Call `.ancestors` on any class to see the exact lookup chain.

---

## Mental Model 6 — Truthiness

Ruby's truthiness rules are simple: only `false` and `nil` are falsy.

```
┌────────────────────────────────────────────────┐
│                TRUTHINESS                      │
│                                                │
│  Falsy values (only TWO):                      │
│    false                                       │
│    nil                                         │
│                                                │
│  Truthy values (everything else):              │
│    true                                        │
│    0         ← 0 is truthy in Ruby!            │
│    ""        ← empty string is truthy!         │
│    []        ← empty array is truthy!          │
│    {}        ← empty hash is truthy!           │
│    42                                          │
│    "hello"                                     │
│    :symbol                                     │
└────────────────────────────────────────────────┘
```

**Examples:**

```ruby
# These are all truthy
if 0
  puts "0 is truthy"   # this DOES print
end

if ""
  puts "empty string is truthy"   # this DOES print
end

if []
  puts "empty array is truthy"    # this DOES print
end

# Only false and nil are falsy
if nil
  puts "won't print"
end

if false
  puts "won't print"
end

# Idiomatic Ruby patterns
user = find_user(id)
if user                    # check if user is not nil
  user.greet
end

# Same with &&
user&.greet                # safe navigation: call greet only if user is not nil
```

**Common mistake:** Coming from Python where `0`, `""`, `[]` are falsy. In Ruby they are truthy.

---

## Mental Model 7 — Return Values

In Ruby, every expression returns a value. Methods return the last evaluated expression automatically.

```
┌──────────────────────────────────────────────────┐
│           IMPLICIT RETURN                        │
│                                                  │
│  def double(n)       ← no explicit return        │
│    n * 2             ← this is returned          │
│  end                                             │
│                                                  │
│  def categorize(n)                               │
│    if n > 0                                      │
│      "positive"      ← returned if n > 0         │
│    elsif n < 0                                   │
│      "negative"      ← returned if n < 0         │
│    else                                          │
│      "zero"          ← returned if n == 0        │
│    end                                           │
│  end                                             │
│                                                  │
│  Use explicit return only for early exits.       │
└──────────────────────────────────────────────────┘
```

**Examples:**

```ruby
# Implicit return
def add(a, b)
  a + b        # returned automatically
end

add(3, 4)      # => 7

# if/else as expression
result = if score >= 90
  "A"
elsif score >= 80
  "B"
else
  "C"
end

# Ternary (short form)
label = age >= 18 ? "adult" : "minor"

# Early return with guard clause
def process(user)
  return "no user" unless user
  return "inactive" unless user.active?
  user.process!
end
```

**Checklist:**
- [ ] I know that methods return the last evaluated expression
- [ ] I can use if/else as an expression (assign its result)
- [ ] I use explicit `return` only for early exits (guard clauses)
- [ ] I understand that blocks also return the last evaluated expression
