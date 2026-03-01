# frozen_string_literal: true

# Lesson 01 — Classes and Objects

## 1) Concept Overview
A class is a reusable blueprint.
An object is one built instance from that blueprint.
Each object has its own identity in memory.
Objects from the same class can hold different state.
Class names use `CamelCase` by convention.

## 2) Mental Model
```
Blueprint vs instance

        class Car
      +----------------+
      | attributes      |
      | methods         |
      +-------+--------+
              |
        new   | new
              v
      +---------------+    +---------------+
      | car_a         |    | car_b         |
      | @brand="Ford" |    | @brand="Tesla"|
      +---------------+    +---------------+

Same class, different objects, different state.
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class Car
  attr_reader :brand

  def initialize(brand)
    @brand = brand
  end

  # TODO: add describe method
  # Hint: "Car(#{brand})"
end
```

## 4) You Type This
- Add a `describe` instance method.
- Create two `Car` objects with different brands.
- Print their descriptions.
- Confirm both are `Car` but not the same object.

## 5) Expand the Example
Add a second attribute like `year`.
Show how two objects can share class but differ in both `brand` and `year`.
Then compare `car_a.class` and `car_b.class`.

## 6) Real-World Application
`User`, `Order`, and `Invoice` are classes in real systems.
Each record loaded from a database becomes an object instance.
You call methods on an object instead of passing raw hashes everywhere.

## 7) Checklist (before moving on)
- [ ] I can define a class.
- [ ] I can instantiate objects with `new`.
- [ ] I can explain why two instances are different objects.
- [ ] I can call methods on an instance.
- [ ] I can inspect an object's class.

## 8) Common Mistakes
- Forgetting to call `new` before using instance methods.
- Confusing class methods with instance methods.
- Assuming two objects with same state are the same identity.

## 9) Debug Flow
- `NoMethodError`? Check whether method belongs to class or instance.
- Unexpected state? Print instance variables with `p object.instance_variables`.
- Wrong class? `p object.class` to confirm receiver type.

## 10) Stretch Goal + sample output
Create `Bike` class too and compare object identities.

Sample output:
```
Car(Ford)
Car(Tesla)
Same class? true
Same object? false
```
