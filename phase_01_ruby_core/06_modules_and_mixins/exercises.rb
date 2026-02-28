# frozen_string_literal: true

# ============================================================
# Lesson 06 — Modules and Mixins
# exercises.rb — Guided exercises with hints
# ============================================================
# Complete each exercise then run:
#   bundle exec rspec test_lesson.rb
# ============================================================

# ------------------------------------------------------------
# Exercise 1: Serializable module
# ------------------------------------------------------------
# Create a module called `Serializable` with two instance methods:
#
#   to_csv  — returns a comma-separated string of all
#             instance variable VALUES (not the names)
#             Example: "Widget,9.99,tools"
#
#   to_h    — returns a Hash mapping variable names (as symbols,
#             without the @) to their values
#             Example: { name: "Widget", price: 9.99, category: "tools" }
#
# Hint: instance_variables returns [:@name, :@price, :@category]
# Hint: instance_variable_get(var) retrieves the value
# Hint: var.to_s.delete("@").to_sym strips the @ and converts to symbol
# Hint: Use .map and .join(",") for to_csv

module Serializable
  def to_csv
    # TODO: return comma-separated values
  end

  def to_h
    # TODO: return a hash of {field_name_symbol: value}
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

# ------------------------------------------------------------
# Exercise 2: ClassMethods via self.included
# ------------------------------------------------------------
# Create a module `Countable` that:
# - When included, adds a CLASS method `instance_count` that
#   returns the number of instances created
# - Also adds an instance method `register` that increments the count
#
# Hint: Use self.included(base) to extend the base class
# Hint: Store count in a class variable like @@count or use a class
#       instance variable via base.instance_variable_set
# Hint: Pattern:
#   def self.included(base)
#     base.extend(ClassMethods)
#     base.instance_variable_set(:@count, 0)
#   end
#   module ClassMethods
#     def instance_count
#       @count
#     end
#   end
#   def register
#     self.class.instance_variable_set(:@count, self.class.instance_count + 1)
#   end

module Countable
  def self.included(base)
    # TODO: extend base with ClassMethods and initialize @count to 0
  end

  module ClassMethods
    def instance_count
      # TODO: return the instance count
    end
  end

  def register
    # TODO: increment the class-level count
  end
end

class Widget
  include Countable

  def initialize(name)
    @name = name
    register
  end
end

# ------------------------------------------------------------
# Exercise 3: Comparable Temperature
# ------------------------------------------------------------
# Create a `Temperature` class that includes `Comparable`.
# Define `<=>` so that Ruby gives you <, >, ==, min, max, sort, etc.
#
# Hint: include Comparable
# Hint: def <=>(other)
#         degrees <=> other.degrees
#       end

class Temperature
  include Comparable
  attr_reader :degrees

  def initialize(degrees)
    @degrees = degrees
  end

  def <=>(other)
    # TODO: compare by degrees
  end

  def to_s
    "#{degrees}°"
  end
end

# ------------------------------------------------------------
# Exercise 4: Enumerable WordCollection
# ------------------------------------------------------------
# Create a class `WordCollection` that includes `Enumerable`.
# It should hold an array of words (passed to initialize as *words).
# Define `each` — Enumerable will handle everything else.
#
# Hint: include Enumerable
# Hint: def each(&block)
#         @words.each(&block)
#       end

class WordCollection
  include Enumerable

  def initialize(*words)
    @words = words
  end

  def each(&block)
    # TODO: delegate to @words.each
  end
end

# ------------------------------------------------------------
# Exercise 5: Namespace module
# ------------------------------------------------------------
# Create a module `Shapes` containing two classes:
#   Circle — initialize(radius), area method (Math::PI * r**2)
#   Rectangle — initialize(width, height), area method (w * h)
# Both area methods should return a Float rounded to 2 decimal places
#
# Hint: module Shapes
#         class Circle
#           ...
#         end
#       end

module Shapes
  class Circle
    def initialize(radius)
      @radius = radius
    end

    def area
      # TODO: return Math::PI * @radius ** 2, rounded to 2 decimal places
      # Hint: (Math::PI * @radius**2).round(2)
    end
  end

  class Rectangle
    def initialize(width, height)
      @width  = width
      @height = height
    end

    def area
      # TODO: return width * height as a Float
      # Hint: (@width * @height).to_f
    end
  end
end
