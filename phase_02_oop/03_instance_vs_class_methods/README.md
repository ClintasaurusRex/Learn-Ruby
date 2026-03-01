# frozen_string_literal: true

# Lesson 03 — Instance vs class methods

## 1) Concept Overview
Instance methods run on objects (`obj.method`).
Class methods run on classes (`Class.method`).
Use instance methods for behavior tied to one object's state.
Use class methods for behavior about the whole type.
Choosing correctly keeps APIs intuitive.

## 2) Mental Model
```
Side-by-side comparison

Class level (shared)
Counter.total_created
        |
        v
+-------------------+
| class Counter     |
| @@total_created   |
| self.total_created|
+---------+---------+
          |
          | new
          v
Instance level (per object)
+-------------------+   +-------------------+
| counter_a         |   | counter_b         |
| @name="A"         |   | @name="B"         |
| increment!        |   | increment!        |
+-------------------+   +-------------------+
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class Counter
  @@total_created = 0

  def self.total_created
    @@total_created
  end

  def initialize(name)
    @name = name
    @@total_created += 1
  end

  # TODO: add instance label method
end
```

## 4) You Type This
- Add an instance `label` method.
- Create two counters.
- Print each label (instance method).
- Print `Counter.total_created` (class method).

## 5) Expand the Example
Add `self.reset_total!` class method.
Reset shared count and verify new object creation starts counting again.

## 6) Real-World Application
`User.find(id)` is class-level behavior.
`user.full_name` is instance-level behavior.
Mixing them up leads to confusing APIs and runtime errors.

## 7) Checklist (before moving on)
- [ ] I can define `self.method_name` class methods.
- [ ] I can define regular instance methods.
- [ ] I can call methods on class and object correctly.
- [ ] I understand shared vs per-object state.
- [ ] I can explain why instance methods can use instance variables.

## 8) Common Mistakes
- Calling instance methods on the class.
- Calling class methods on instances.
- Using class variables when class instance variables are better.

## 9) Debug Flow
- `NoMethodError`? Check receiver type first (`p receiver.class`).
- Wrong count? Verify where shared state is incremented.
- Label wrong? Print instance variable values inside method.

## 10) Stretch Goal + sample output
Add class method that returns all created names.

Sample output:
```
Counter<A>
Counter<B>
Total created: 2
```
