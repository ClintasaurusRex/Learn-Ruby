# frozen_string_literal: true

# ============================================================
# Lesson 06 — Modules and Mixins
# examples.rb — Complete runnable examples
# ============================================================
# Run with:  ruby examples.rb
# ============================================================

puts "=" * 60
puts "LESSON 06: Modules and Mixins"
puts "=" * 60

# ------------------------------------------------------------
# 1. Module as a Namespace
# ------------------------------------------------------------
puts "\n--- 1. Namespacing ---"

module Animals
  class Dog
    def speak = "Woof!"
  end

  class Cat
    def speak = "Meow!"
  end
end

puts Animals::Dog.new.speak   # => Woof!
puts Animals::Cat.new.speak   # => Meow!

# Nested namespaces
module API
  module V1
    class UsersController
      def index = "API v1 users"
    end
  end

  module V2
    class UsersController
      def index = "API v2 users"
    end
  end
end

puts API::V1::UsersController.new.index   # => API v1 users
puts API::V2::UsersController.new.index   # => API v2 users

# ------------------------------------------------------------
# 2. include — Instance Methods
# ------------------------------------------------------------
puts "\n--- 2. include (instance methods) ---"

module Greetable
  def greet
    "Hello, I'm #{name}!"
  end

  def farewell
    "Goodbye from #{name}!"
  end
end

module Describable
  def describe
    vars = instance_variables.map do |v|
      "#{v}=#{instance_variable_get(v)}"
    end
    "#{self.class.name}(#{vars.join(', ')})"
  end
end

class Person
  include Greetable
  include Describable

  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age  = age
  end
end

bob = Person.new("Bob", 30)
puts bob.greet     # => Hello, I'm Bob!
puts bob.farewell  # => Goodbye from Bob!
puts bob.describe  # => Person(@name=Bob, @age=30)

# Ancestor chain — note the order
puts Person.ancestors.inspect
# => [Person, Describable, Greetable, Object, Kernel, BasicObject]

# ------------------------------------------------------------
# 3. extend — Class Methods
# ------------------------------------------------------------
puts "\n--- 3. extend (class methods) ---"

module Finder
  def find_by_name(name)
    "Looking up #{name} in #{self.name} records"
  end

  def count
    "Counting all #{self.name} records"
  end
end

class User
  extend Finder
end

puts User.find_by_name("Alice")   # => Looking up Alice in User records
puts User.count                   # => Counting all User records

# include AND extend together (common pattern)
module ActiveRecord
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def table_name
      name.downcase + "s"
    end
  end

  def save
    "Saving #{self.class.name} to #{self.class.table_name}"
  end
end

class Post
  include ActiveRecord
end

post = Post.new
puts Post.table_name     # => posts  (class method from extend)
puts post.save           # => Saving Post to posts  (instance method from include)

# ------------------------------------------------------------
# 4. prepend — Wrap Method Calls
# ------------------------------------------------------------
puts "\n--- 4. prepend ---"

module Loggable
  def greet
    puts "[LOG] greet called"
    result = super
    puts "[LOG] greet returned: #{result}"
    result
  end
end

class Greeter
  prepend Loggable

  def greet
    "Hello!"
  end
end

Greeter.new.greet
# [LOG] greet called
# [LOG] greet returned: Hello!

puts Greeter.ancestors.first(3).inspect
# => [Loggable, Greeter, Object]  — Loggable is FIRST

# ------------------------------------------------------------
# 5. Module Constants
# ------------------------------------------------------------
puts "\n--- 5. Constants ---"

module Config
  VERSION     = "2.1.0"
  MAX_RETRIES = 5
  TIMEOUT     = 30
  LOG_LEVELS  = %w[debug info warn error].freeze
end

puts Config::VERSION              # => 2.1.0
puts Config::LOG_LEVELS.inspect   # => ["debug", "info", "warn", "error"]

# ------------------------------------------------------------
# 6. module_function
# ------------------------------------------------------------
puts "\n--- 6. module_function ---"

module MathHelper
  module_function

  def circle_area(radius)
    Math::PI * radius ** 2
  end

  def percentage(part, whole)
    (part.to_f / whole * 100).round(2)
  end
end

# Can call directly on the module
puts MathHelper.circle_area(5).round(2)    # => 78.54
puts MathHelper.percentage(25, 200)        # => 12.5

# Also works when included (but methods become private)
class Calculator
  include MathHelper

  def compute_area(r)
    circle_area(r)   # private method from module_function
  end
end

puts Calculator.new.compute_area(3).round(2)   # => 28.27

# ------------------------------------------------------------
# 7. Comparable Mixin
# ------------------------------------------------------------
puts "\n--- 7. Comparable ---"

class Temperature
  include Comparable

  attr_reader :degrees

  def initialize(degrees)
    @degrees = degrees
  end

  def <=>(other)
    degrees <=> other.degrees
  end

  def to_s
    "#{degrees}°"
  end
end

temps = [Temperature.new(100), Temperature.new(37), Temperature.new(0), Temperature.new(22)]

puts temps.min        # => 0°
puts temps.max        # => 100°
puts temps.sort.map(&:to_s).inspect   # => ["0°", "22°", "37°", "100°"]
puts Temperature.new(37).between?(Temperature.new(0), Temperature.new(100))  # => true
puts temps.minmax.map(&:to_s).inspect # => ["0°", "100°"]

# ------------------------------------------------------------
# 8. Enumerable Mixin
# ------------------------------------------------------------
puts "\n--- 8. Enumerable ---"

class NumberList
  include Enumerable

  def initialize(*numbers)
    @numbers = numbers
  end

  # Must define each — Enumerable provides the rest
  def each(&block)
    @numbers.each(&block)
  end
end

list = NumberList.new(5, 2, 8, 1, 9, 3)

puts list.sort.inspect           # => [1, 2, 3, 5, 8, 9]
puts list.min                    # => 1
puts list.max                    # => 9
puts list.select { |n| n > 4 }.inspect  # => [5, 8, 9]
puts list.map { |n| n * 2 }.inspect     # => [10, 4, 16, 2, 18, 6]
puts list.sum                    # => 28

puts "\n" + "=" * 60
puts "All examples complete!"
puts "=" * 60
