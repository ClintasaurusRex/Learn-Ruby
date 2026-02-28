# OOP Quick Reference ⚡

> Classes, inheritance, modules, and patterns. Scannable in 60 seconds.

---

## Class Anatomy

```ruby
class Person
  # Constants
  MAX_AGE = 150

  # Class variable (shared by all instances)
  @@count = 0

  # Attribute accessors
  attr_reader   :name       # getter only
  attr_writer   :email      # setter only
  attr_accessor :age        # getter + setter

  # Constructor
  def initialize(name, age)
    @name = name
    @age  = age
    @@count += 1
  end

  # Instance method
  def greet
    "Hello, I'm #{@name}"
  end

  # Class method
  def self.count
    @@count
  end

  # to_s for string representation
  def to_s
    "#{@name} (#{@age})"
  end

  protected

  def secret_number
    42
  end

  private

  def internal_helper
    "internal"
  end
end

person = Person.new("Alice", 30)
person.name          # "Alice"
person.age           # 30
person.age = 31      # setter
Person.count         # 1
puts person          # "Alice (30)" — calls to_s
```

---

## Access Modifiers

```ruby
class MyClass
  def public_method     # anyone can call
    "public"
  end

  protected
  def protected_method  # only this class and subclasses
    "protected"
  end

  private
  def private_method    # only inside this class
    "private"
  end
  
  # Ruby 2.7+ inline private
  private def helper
    "also private"
  end
end
```

---

## Inheritance

```ruby
class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def speak
    raise NotImplementedError, "#{self.class} must implement #speak"
  end

  def breathe
    "#{name} breathes"
  end
end

class Dog < Animal
  def speak
    "Woof!"
  end

  def fetch
    "#{name} fetches!"
  end
end

class GoldenRetriever < Dog
  def initialize(name, friendly: true)
    super(name)               # call parent initialize
    @friendly = friendly
  end

  def speak
    super + " " + super       # call parent speak: "Woof! Woof!"
  end
end

fido = GoldenRetriever.new("Fido")
fido.breathe   # from Animal
fido.fetch     # from Dog
fido.speak     # from GoldenRetriever

fido.is_a?(GoldenRetriever)  # true
fido.is_a?(Dog)              # true
fido.is_a?(Animal)           # true
GoldenRetriever.ancestors
# [GoldenRetriever, Dog, Animal, Object, ...]
```

---

## Modules — Include vs Extend

```ruby
module Greetable
  def greet                        # instance method
    "Hello, I'm #{name}"
  end
end

module ClassMethods
  def describe                     # will become class method
    "I am #{self.name} class"
  end
end

class User
  include Greetable                # adds greet as instance method
  extend ClassMethods              # adds describe as class method
  attr_reader :name
  def initialize(name) = @name = name
end

User.new("Alice").greet   # instance method
User.describe             # class method

# Include both with ActiveSupport::Concern pattern
module Searchable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def search(query)
      where("name LIKE ?", "%#{query}%")
    end
  end

  def matches?(query)
    name.include?(query)
  end
end
```

---

## Comparable

```ruby
class Weight
  include Comparable

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def <=>(other)         # required method
    value <=> other.value
  end
end

weights = [Weight.new(5), Weight.new(2), Weight.new(8)]
weights.sort             # sorted by value
weights.min              # Weight with value 2
weights.max              # Weight with value 8
Weight.new(5) > Weight.new(3)   # true
Weight.new(5).between?(Weight.new(3), Weight.new(7))  # true
```

---

## Enumerable

```ruby
class NumberCollection
  include Enumerable

  def initialize(numbers)
    @numbers = numbers
  end

  def each(&block)       # required method
    @numbers.each(&block)
  end
end

coll = NumberCollection.new([3, 1, 4, 1, 5, 9])
coll.sort              # [1, 1, 3, 4, 5, 9]
coll.select(&:odd?)    # [3, 1, 1, 5, 9]
coll.map { |n| n * 2 } # [6, 2, 8, 2, 10, 18]
coll.min               # 1
coll.max               # 9
coll.sum               # 23
coll.include?(4)       # true
```

---

## Common Patterns

### Singleton Pattern

```ruby
class Config
  @instance = nil

  def self.instance
    @instance ||= new
  end

  private_class_method :new

  def initialize
    @settings = {}
  end

  def set(key, value)
    @settings[key] = value
  end

  def get(key)
    @settings[key]
  end
end

Config.instance.set(:debug, true)
Config.instance.get(:debug)   # true
```

### Factory Pattern

```ruby
class AnimalFactory
  def self.create(type, name)
    case type
    when :dog  then Dog.new(name)
    when :cat  then Cat.new(name)
    else raise ArgumentError, "Unknown animal: #{type}"
    end
  end
end

pet = AnimalFactory.create(:dog, "Rex")
```

---

## Duck Typing

```ruby
# Don't check the class, check the capability
def print_area(shape)
  if shape.respond_to?(:area)
    puts shape.area
  else
    raise ArgumentError, "#{shape.class} doesn't have an area"
  end
end

# Works with any object that has #area
print_area(Circle.new(5))
print_area(Rectangle.new(3, 4))
print_area(Triangle.new(3, 4))
```

---

## Composition

```ruby
class Logger
  def log(message)
    puts "[#{Time.now}] #{message}"
  end
end

class EmailSender
  def send_email(to, subject, body)
    puts "Sending '#{subject}' to #{to}"
  end
end

class UserRegistration
  def initialize
    @logger = Logger.new
    @mailer = EmailSender.new
  end

  def register(user)
    user.save
    @logger.log("User registered: #{user.email}")
    @mailer.send_email(user.email, "Welcome!", "Hello!")
  end
end
```
