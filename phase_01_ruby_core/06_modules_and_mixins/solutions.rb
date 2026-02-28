# frozen_string_literal: true

# ============================================================
# Lesson 06 — Modules and Mixins
# solutions.rb — Solutions with plain-language explanations
# ============================================================

# ------------------------------------------------------------
# Exercise 1: Serializable
# ------------------------------------------------------------
# instance_variables returns the list of @ variables on the object.
# We map over them to get their values with instance_variable_get.
# For to_h, we strip the leading @ from the variable name and
# convert to a symbol so the hash looks like { name: "Widget" }.

module Serializable
  def to_csv
    instance_variables.map { |v| instance_variable_get(v) }.join(",")
  end

  def to_h
    instance_variables.each_with_object({}) do |var, hash|
      key = var.to_s.delete("@").to_sym
      hash[key] = instance_variable_get(var)
    end
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
puts widget.to_csv                # => Widget,9.99,tools
puts widget.to_h.inspect          # => {:name=>"Widget", :price=>9.99, :category=>"tools"}

# ------------------------------------------------------------
# Exercise 2: Countable
# ------------------------------------------------------------
# self.included(base) is a hook Ruby calls when a module is included.
# We use it to:
#   1. Add class methods via extend
#   2. Initialize a counter as a class instance variable (@count)
# The register instance method increments the counter by reading
# and writing the class instance variable through self.class.

module Countable
  def self.included(base)
    base.extend(ClassMethods)
    base.instance_variable_set(:@count, 0)
  end

  module ClassMethods
    def instance_count
      @count
    end
  end

  def register
    current = self.class.instance_count
    self.class.instance_variable_set(:@count, current + 1)
  end
end

class Widget
  include Countable

  def initialize(name)
    @name = name
    register
  end
end

puts Widget.instance_count   # => 0
Widget.new("Bolt")
Widget.new("Nut")
Widget.new("Washer")
puts Widget.instance_count   # => 3

# ------------------------------------------------------------
# Exercise 3: Comparable Temperature
# ------------------------------------------------------------
# <=> is the "spaceship operator" — it returns -1, 0, or 1.
# By delegating to degrees <=> other.degrees, we let Ruby's
# Integer handle the comparison. Then Comparable gives us
# <, >, ==, between?, min, max, sort — all for free.

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

temps = [Temperature.new(100), Temperature.new(37), Temperature.new(0)]
puts temps.min        # => 0°
puts temps.max        # => 100°
puts temps.sort.map(&:to_s).inspect   # => ["0°", "37°", "100°"]
puts Temperature.new(37).between?(Temperature.new(0), Temperature.new(100))  # => true

# ------------------------------------------------------------
# Exercise 4: Enumerable WordCollection
# ------------------------------------------------------------
# Enumerable requires only one method: each.
# Once each is defined, all the other iteration methods —
# map, select, reject, sort, min, max, count, sum, etc. —
# are provided automatically by the Enumerable module.

class WordCollection
  include Enumerable

  def initialize(*words)
    @words = words
  end

  def each(&block)
    @words.each(&block)
  end
end

wc = WordCollection.new("apple", "banana", "cherry", "date")
puts wc.sort.inspect                         # => ["apple", "banana", "cherry", "date"]
puts wc.select { |w| w.length > 5 }.inspect # => ["banana", "cherry"]
puts wc.map(&:upcase).inspect                # => ["APPLE", "BANANA", "CHERRY", "DATE"]
puts wc.min                                  # => apple
puts wc.max                                  # => date
puts wc.count                                # => 4

# ------------------------------------------------------------
# Exercise 5: Shapes namespace
# ------------------------------------------------------------
# Modules let us group related classes under a common name.
# Shapes::Circle and Shapes::Rectangle won't collide with any
# other Circle or Rectangle class elsewhere in the codebase.

module Shapes
  class Circle
    def initialize(radius)
      @radius = radius
    end

    def area
      (Math::PI * @radius**2).round(2)
    end
  end

  class Rectangle
    def initialize(width, height)
      @width  = width
      @height = height
    end

    def area
      (@width * @height).to_f
    end
  end
end

puts Shapes::Circle.new(5).area      # => 78.54
puts Shapes::Circle.new(1).area      # => 3.14
puts Shapes::Rectangle.new(4, 6).area # => 24.0
puts Shapes::Rectangle.new(3, 3).area # => 9.0
