# Lesson 06 — Modules and Mixins

---

## 1) Concept Overview

Modules are containers for methods and constants — like a toolbox.
They serve two purposes: **namespacing** (avoiding name collisions) and **mixins** (sharing behavior across classes).
`include` mixes module methods in as instance methods.
`extend` mixes module methods in as class methods.
Ruby uses mixins as a way to share behavior without multiple inheritance.

---

## 2) Mental Model Diagram

```
MODULE AS NAMESPACE          MODULE AS MIXIN
──────────────────           ──────────────────────────────
module Animals               module Greetable
  class Dog; end               def greet
  class Cat; end                 "Hello, I'm #{name}"
end                            end
                             end
Animals::Dog.new
Animals::Cat.new             class Person
                               include Greetable   ← add instance methods
                               attr_reader :name
                               def initialize(name)
                                 @name = name
                               end
                             end

                             Person.new("Alice").greet
                             # => "Hello, I'm Alice"

HOW include WORKS
─────────────────────────────────────────────────────────────

  Person.ancestors
  #=> [Person, Greetable, Object, Kernel, BasicObject]
                   ↑
         inserted here in the lookup chain

include → instance methods
extend  → class methods (called on the class itself)
prepend → inserted BEFORE the class in the lookup chain
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

module Greetable
  def greet
    "Hello, I'm #{name}"
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
puts alice.greet   # => Hello, I'm Alice
puts Person.ancestors.inspect
# => [Person, Greetable, Object, Kernel, BasicObject]
```

---

## 4) You Type This

Open `starter.rb` and:

1. Create a module `Serializable` with a `to_csv` instance method that outputs `field1,field2,...`
2. Create a module `ClassInfo` with a `describe` class method that prints the class name and ancestor count
3. Use `include` for `Serializable` and `extend` for `ClassInfo` on a `Product` class
4. Create a `Loggable` module with `prepend` behavior that wraps method calls with log output

---

## 5) Expand the Example

**Mixins share behavior across unrelated classes:**

```ruby
module Describable
  def describe
    vars = instance_variables.map do |var|
      "#{var}=#{instance_variable_get(var)}"
    end
    "#{self.class.name}(#{vars.join(', ')})"
  end
end

class Car
  include Describable
  def initialize(make, model)
    @make = make
    @model = model
  end
end

class Book
  include Describable
  def initialize(title, author)
    @title = title
    @author = author
  end
end

puts Car.new("Toyota", "Corolla").describe
# => Car(@make=Toyota, @model=Corolla)
puts Book.new("Ruby Way", "Fulton").describe
# => Book(@title=Ruby Way, @author=Fulton)
```

**`extend` for class methods:**

```ruby
module Finder
  def find_by_name(name)
    "Finding #{name} in #{self.name}"
  end
end

class User
  extend Finder
end

puts User.find_by_name("Alice")   # => Finding Alice in User
```

**Constants in modules (namespacing):**

```ruby
module Config
  VERSION   = "1.0.0"
  MAX_RETRIES = 3
  TIMEOUT     = 30
end

puts Config::VERSION     # => 1.0.0
puts Config::MAX_RETRIES # => 3
```

---

## 6) Real-World Application

> *"How would you use this at work?"*

- **Rails Concerns** are modules you mix into models or controllers to share logic (e.g., `Searchable`, `Auditable`, `Taggable`)
- **Comparable module**: mix in `<=>` and get `<`, `>`, `between?`, `sort`, `min`, `max` for free
- **Enumerable module**: mix in `each` and get `map`, `select`, `reject`, `sort_by`, etc.
- **Namespacing**: keep your classes organized — `API::V1::UsersController` vs `API::V2::UsersController`

```ruby
# Real-world Rails concern pattern
module Timestampable
  def self.included(base)
    base.before_save :set_timestamps
  end

  def set_timestamps
    self.updated_at = Time.now
    self.created_at ||= Time.now
  end
end
```

---

## 7) Checklist

Before moving on, confirm you can:

- [ ] Create a module with `module Name ... end`
- [ ] Use `include` to add module methods as instance methods
- [ ] Use `extend` to add module methods as class methods
- [ ] Use `prepend` to insert a module before the class in the lookup chain
- [ ] Use `Module::CONSTANT` syntax
- [ ] Explain what `ancestors` shows and why order matters
- [ ] Use `module_function` to make methods callable as both module and instance methods
- [ ] Use `self.included(base)` hook for setup when a module is included

---

## 8) Common Mistakes

| Mistake | Fix |
|---------|-----|
| Using `include` when you want class methods | Use `extend` for class methods |
| Module methods calling instance variables that don't exist | Include the module only in classes that have those instance variables |
| Name collisions between module methods and class methods | Check `ancestors` chain; prepend if you need to wrap |
| `module_function` vs `extend self` | They're similar; `module_function` makes methods private as instance methods |
| Forgetting `self.included` hook | Use it when the mixin needs to add callbacks, validations, or class-level config |

---

## 9) Debug Flow

```
Method not found after include?
  └─ puts MyClass.ancestors.inspect
  └─ Is the module in the chain? If not, did you forget include?
  └─ Did you include it in the right class?

extend vs include confusion?
  └─ instance.method   → use include
  └─ ClassName.method  → use extend

Module constant not accessible?
  └─ Use Module::CONSTANT syntax (not just CONSTANT)
  └─ Check you're outside the module scope

Unexpected method override?
  └─ Check ancestors order — first match wins
  └─ Use prepend if you want module to run BEFORE the class method
```

---

## 10) Stretch Goal

Implement the `Comparable` module from scratch on a `Temperature` class:

```ruby
class Temperature
  include Comparable

  attr_reader :degrees

  def initialize(degrees)
    @degrees = degrees
  end

  # TODO: implement <=> so Comparable gives you <, >, ==, between?, clamp
  def <=>(other)
    degrees <=> other.degrees
  end
end

temps = [Temperature.new(100), Temperature.new(37), Temperature.new(0)]
puts temps.min.degrees    # => 0
puts temps.max.degrees    # => 100
puts temps.sort.map(&:degrees).inspect  # => [0, 37, 100]
puts Temperature.new(37).between?(Temperature.new(0), Temperature.new(100))  # => true
```
