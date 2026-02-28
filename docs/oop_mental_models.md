# OOP Mental Models 🏗️

> 7 mental models for thinking about Object-Oriented Programming in Ruby.

---

## Mental Model 1 — Class as Blueprint, Object as Instance

A class is like a blueprint. Objects are the things built from that blueprint.

```
┌─────────────────────────────────────────────────────────┐
│                  CLASS → OBJECT                         │
│                                                         │
│  Blueprint (Class)          Building (Object/Instance)  │
│  ─────────────────          ───────────────────────     │
│  class Dog                  fido = Dog.new("Fido")      │
│    attr_reader :name        rex  = Dog.new("Rex")       │
│    def initialize(name)                                 │
│      @name = name           fido.name  # => "Fido"      │
│    end                      rex.name   # => "Rex"       │
│    def speak                fido.speak # => "Woof!"     │
│      "Woof!"                                            │
│    end                      Both objects share the      │
│  end                        class behavior but have     │
│                             their OWN state (@name)     │
└─────────────────────────────────────────────────────────┘
```

**Example:**

```ruby
class Car
  attr_reader :make, :model, :year

  def initialize(make, model, year)
    @make  = make
    @model = model
    @year  = year
    @mileage = 0
  end

  def drive(miles)
    @mileage += miles
  end

  def info
    "#{@year} #{@make} #{@model} — #{@mileage} miles"
  end
end

my_car = Car.new("Toyota", "Camry", 2023)
your_car = Car.new("Honda", "Civic", 2022)

my_car.drive(100)
puts my_car.info    # => "2023 Toyota Camry — 100 miles"
puts your_car.info  # => "2022 Honda Civic — 0 miles"
```

---

## Mental Model 2 — Inheritance Chain

Inheritance lets child classes share behavior from parent classes.

```
┌───────────────────────────────────────────────────────┐
│                INHERITANCE CHAIN                      │
│                                                       │
│            BasicObject                                │
│                 ↑                                     │
│              Object                                   │
│                 ↑                                     │
│             Animal          ← parent                  │
│           /        \                                  │
│         Dog         Cat     ← children                │
│        /                                              │
│   GoldenRetriever           ← grandchild              │
│                                                       │
│  GoldenRetriever inherits from: Dog → Animal → Object │
└───────────────────────────────────────────────────────┘
```

**Example:**

```ruby
class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def breathe
    "#{name} breathes air"
  end

  def to_s
    name
  end
end

class Dog < Animal
  def speak
    "Woof!"
  end
end

class Cat < Animal
  def speak
    "Meow!"
  end
end

class GoldenRetriever < Dog
  def fetch
    "#{name} fetches the ball!"
  end
end

buddy = GoldenRetriever.new("Buddy")
buddy.breathe  # => "Buddy breathes air"  (from Animal)
buddy.speak    # => "Woof!"               (from Dog)
buddy.fetch    # => "Buddy fetches the ball!" (own method)

GoldenRetriever.ancestors
# => [GoldenRetriever, Dog, Animal, Object, Kernel, BasicObject]
```

**Common mistake:** Deep inheritance hierarchies become rigid and hard to change. Prefer composition when hierarchies go more than 2 levels deep.

---

## Mental Model 3 — Mixin Layering

Modules add behavior to classes without inheritance. They slot in between the class and its superclass.

```
┌───────────────────────────────────────────────────────┐
│                  MIXIN LAYERING                       │
│                                                       │
│  class Robot                                          │
│    include Rechargeable                               │
│    include Programmable                               │
│  end                                                  │
│                                                       │
│  Lookup order:                                        │
│                                                       │
│    Robot                                              │
│      ↑                                                │
│    Programmable  ← last included goes first           │
│      ↑                                                │
│    Rechargeable  ← first included goes last           │
│      ↑                                                │
│    Object                                             │
│                                                       │
│  Robot.ancestors                                      │
│  # [Robot, Programmable, Rechargeable, Object, ...]   │
└───────────────────────────────────────────────────────┘
```

**Example:**

```ruby
module Swimmable
  def swim
    "#{name} swims"
  end
end

module Runnable
  def run
    "#{name} runs"
  end
end

module Flyable
  def fly
    "#{name} flies"
  end
end

class Duck
  include Swimmable
  include Runnable
  include Flyable

  attr_reader :name

  def initialize(name)
    @name = name
  end
end

donald = Duck.new("Donald")
donald.swim  # => "Donald swims"
donald.run   # => "Donald runs"
donald.fly   # => "Donald flies"
```

---

## Mental Model 4 — Composition vs Inheritance

Prefer composition ("has-a") over inheritance ("is-a") for flexible code.

```
┌──────────────────────────────────────────────────────────┐
│           INHERITANCE  vs  COMPOSITION                   │
│                                                          │
│  Inheritance ("is-a"):        Composition ("has-a"):     │
│  ──────────────────────       ─────────────────────────  │
│  class ElectricCar < Car      class Car                  │
│    # Car IS-A Car (good)      # Car HAS-A Engine         │
│  end                          # Car HAS-A GPS            │
│                               # Car HAS-A Stereo         │
│  class Car < Vehicle          end                        │
│    class < Machine              ← easy to swap parts     │
│      class < PhysicalObject       without changing Car   │
│                                                          │
│  Deep hierarchies become       Shallow, flexible design  │
│  rigid and fragile             Easy to test in isolation │
└──────────────────────────────────────────────────────────┘
```

**Example:**

```ruby
# Inheritance approach (fragile if requirements change)
class Vehicle; end
class Car < Vehicle; end
class ElectricCar < Car; end   # what if ElectricCar doesn't share Car's engine?

# Composition approach (flexible)
class Engine
  def start = "Engine started"
end

class ElectricMotor
  def start = "Motor started silently"
end

class Car
  def initialize(engine)
    @engine = engine
  end

  def start
    @engine.start
  end
end

gas_car = Car.new(Engine.new)
electric_car = Car.new(ElectricMotor.new)

gas_car.start       # => "Engine started"
electric_car.start  # => "Motor started silently"
```

---

## Mental Model 5 — Duck Typing

"If it walks like a duck and quacks like a duck, it's a duck." Ruby cares about behavior, not class.

```
┌───────────────────────────────────────────────────────┐
│                  DUCK TYPING                          │
│                                                       │
│  Traditional: "Is this a Duck?"                       │
│    if animal.is_a?(Duck)  ← checking the type        │
│                                                       │
│  Duck typing: "Can this quack?"                       │
│    if animal.respond_to?(:quack)  ← checking behavior │
│                                                       │
│  The method doesn't care what CLASS the object is.   │
│  It only cares that it has the right METHOD.          │
│                                                       │
│  class Dog;  def sound = "Woof"  end                 │
│  class Cat;  def sound = "Meow"  end                 │
│  class Duck; def sound = "Quack" end                 │
│                                                       │
│  [Dog.new, Cat.new, Duck.new].each do |a|             │
│    puts a.sound   ← works on all three               │
│  end                                                  │
└───────────────────────────────────────────────────────┘
```

**Example:**

```ruby
class Printer
  def print(document)
    document.to_s   # calls to_s — doesn't care what type document is
  end
end

class Invoice
  def to_s
    "Invoice #1234"
  end
end

class Report
  def to_s
    "Q4 Report"
  end
end

printer = Printer.new
printer.print(Invoice.new)  # => "Invoice #1234"
printer.print(Report.new)   # => "Q4 Report"
printer.print("Hello!")     # => "Hello!" — strings have to_s too!
```

---

## Mental Model 6 — Encapsulation Boundaries

Encapsulation means hiding internal details. Control what's visible with access modifiers.

```
┌──────────────────────────────────────────────────────────┐
│                 ENCAPSULATION LAYERS                     │
│                                                          │
│  ┌─────────────────────────────────────────────────┐     │
│  │ public (visible to everyone)                    │     │
│  │   user.name, user.save                          │     │
│  │ ┌─────────────────────────────────────────────┐ │     │
│  │ │ protected (visible to same class/subclasses) │ │     │
│  │ │   used for comparing instances internally    │ │     │
│  │ │ ┌───────────────────────────────────────┐   │ │     │
│  │ │ │ private (visible only inside the class│   │ │     │
│  │ │ │   encrypt_password, validate_email    │   │ │     │
│  │ │ └───────────────────────────────────────┘   │ │     │
│  │ └─────────────────────────────────────────────┘ │     │
│  └─────────────────────────────────────────────────┘     │
└──────────────────────────────────────────────────────────┘
```

**Example:**

```ruby
class BankAccount
  attr_reader :balance

  def initialize(initial_balance)
    @balance = initial_balance
  end

  def deposit(amount)
    validate_amount!(amount)
    @balance += amount
  end

  def withdraw(amount)
    validate_amount!(amount)
    ensure_sufficient_funds!(amount)
    @balance -= amount
  end

  protected

  def ==(other)
    balance == other.balance
  end

  private

  def validate_amount!(amount)
    raise ArgumentError, "Amount must be positive" unless amount.positive?
  end

  def ensure_sufficient_funds!(amount)
    raise "Insufficient funds" if amount > @balance
  end
end

account = BankAccount.new(1000)
account.deposit(500)
account.withdraw(200)
account.balance       # => 1300
account.validate_amount!(100)  # => NoMethodError: private method
```

---

## Mental Model 7 — Polymorphism

One interface, many implementations. The same method name works differently on different objects.

```
┌───────────────────────────────────────────────────────┐
│                  POLYMORPHISM                         │
│                                                       │
│  area method on different shapes:                     │
│                                                       │
│  Circle.new(5).area    → π × r²   = 78.5             │
│  Rectangle.new(4,6).area → w × h  = 24               │
│  Triangle.new(3,4).area → ½ × b×h = 6                │
│                                                       │
│  shapes = [circle, rectangle, triangle]               │
│  shapes.each { |s| puts s.area }  ← same call,       │
│                                     different result  │
└───────────────────────────────────────────────────────┘
```

**Example:**

```ruby
class Shape
  def area
    raise NotImplementedError, "#{self.class} must implement #area"
  end

  def describe
    "I am a #{self.class.name} with area #{area.round(2)}"
  end
end

class Circle < Shape
  def initialize(radius)
    @radius = radius
  end

  def area
    Math::PI * @radius ** 2
  end
end

class Rectangle < Shape
  def initialize(width, height)
    @width  = width
    @height = height
  end

  def area
    @width * @height
  end
end

class Triangle < Shape
  def initialize(base, height)
    @base   = base
    @height = height
  end

  def area
    0.5 * @base * @height
  end
end

shapes = [
  Circle.new(5),
  Rectangle.new(4, 6),
  Triangle.new(3, 4)
]

shapes.each { |s| puts s.describe }
# I am a Circle with area 78.54
# I am a Rectangle with area 24
# I am a Triangle with area 6.0
```

**Checklist:**
- [ ] I can create a class with initialize, instance methods, and attr_accessor
- [ ] I can use inheritance with < and call super
- [ ] I can include a module to add shared behavior
- [ ] I understand when to use composition instead of inheritance
- [ ] I can write code that uses duck typing (doesn't check object type)
- [ ] I know the difference between public, protected, and private
- [ ] I can write polymorphic code with a shared interface

**Common mistakes:**
- Using `protected` when you mean `private` — use `private` for internal methods
- Inheriting just to share code — prefer modules or composition for code sharing
- Checking types with `is_a?` instead of relying on duck typing
