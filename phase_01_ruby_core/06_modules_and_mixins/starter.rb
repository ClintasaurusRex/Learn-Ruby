# frozen_string_literal: true

# ============================================================
# Lesson 06 — Modules and Mixins
# starter.rb — Working starter code with TODOs and Hints
# ============================================================
# Run this file with:  ruby starter.rb
# ============================================================

# ------------------------------------------------------------
# PART 1: Module as a mixin (include)
# ------------------------------------------------------------

# This already works — study the pattern
module Greetable
  def greet
    "Hello, I'm #{name}"
  end

  def farewell
    "Goodbye from #{name}!"
  end
end

class Person
  include Greetable
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

alice = Person.new("Alice")
puts alice.greet     # => Hello, I'm Alice
puts alice.farewell  # => Goodbye from Alice!

# The module appears in the ancestor chain
puts Person.ancestors.inspect
# => [Person, Greetable, Object, Kernel, BasicObject]

# ------------------------------------------------------------
# PART 2: extend (class-level methods)
# ------------------------------------------------------------

module ClassInfo
  # TODO: Add a class method `describe` that prints:
  # "Class: <ClassName>, Ancestors: <count>"
  # Hint: self.name gives the class name inside a class method
  # Hint: self.ancestors.count gives the ancestor count
  def describe
    # TODO: build the string and puts it
    # Hint: "Class: #{name}, Ancestors: #{ancestors.count}"
  end
end

class Robot
  extend ClassInfo
  # TODO: uncomment and test: Robot.describe
end

Robot.describe
# => Class: Robot, Ancestors: <number>

# ------------------------------------------------------------
# PART 3: module with constants (namespacing)
# ------------------------------------------------------------

module AppConfig
  VERSION     = "1.0.0"
  MAX_RETRIES = 3
  TIMEOUT     = 30

  # TODO: Add a constant LOG_LEVEL with value "info"
  # Hint: LOG_LEVEL = "info"
end

puts AppConfig::VERSION      # => 1.0.0
puts AppConfig::MAX_RETRIES  # => 3
puts AppConfig::TIMEOUT      # => 30
# TODO: puts AppConfig::LOG_LEVEL

# ------------------------------------------------------------
# PART 4: Serializable module (include for instance methods)
# ------------------------------------------------------------

module Serializable
  # TODO: Add an instance method `to_csv` that returns a
  # comma-separated string of all instance variable values
  # Hint: instance_variables returns an array like [:@name, :@age]
  # Hint: instance_variable_get(var) retrieves the value
  # Hint: .map { |var| instance_variable_get(var) }.join(",")
  def to_csv
    # TODO: implement
  end
end

class Product
  include Serializable

  def initialize(name, price, category)
    @name     = name
    @price    = price
    @category = category
  end
end

widget = Product.new("Widget", 9.99, "tools")
puts widget.to_csv   # => Widget,9.99,tools

# ------------------------------------------------------------
# PART 5: self.included hook
# ------------------------------------------------------------

module Trackable
  def self.included(base)
    # This runs when the module is included in a class
    # base is the class that is including this module
    puts "#{name} included in #{base.name}"
  end

  def track
    "Tracking #{self.class.name} instance"
  end
end

class Order
  include Trackable   # => Trackable included in Order
end

order = Order.new
puts order.track   # => Tracking Order instance

# ------------------------------------------------------------
# PART 6: Comparable mixin
# ------------------------------------------------------------

module Comparable
  # Ruby's built-in Comparable module — we just need to define <=>
end

class Weight
  include Comparable
  attr_reader :value

  def initialize(value)
    @value = value
  end

  # TODO: Define <=> to compare by value
  # Hint: def <=>(other)
  #         value <=> other.value
  #       end
  def <=>(other)
    # TODO: implement
  end

  def to_s
    "#{value}kg"
  end
end

weights = [Weight.new(5), Weight.new(1), Weight.new(3)]
# TODO: uncomment these once <=> is implemented:
# puts weights.min     # => 1kg
# puts weights.max     # => 5kg
# puts weights.sort.map(&:to_s).inspect  # => ["1kg", "3kg", "5kg"]

# ============================================================
# Run with:  ruby starter.rb
# Fill in the TODOs, then run the tests:
#   bundle exec rspec test_lesson.rb
# ============================================================
