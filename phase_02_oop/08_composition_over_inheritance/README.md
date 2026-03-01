# frozen_string_literal: true

# Lesson 08 — Composition Over Inheritance

## 1. Concept Overview
Composition means objects collaborate instead of inheriting everything.
Inheritance is useful for strict "is-a" relationships.
Composition is better for flexible "has-a" relationships.
You can swap composed parts without rewriting the parent class.
This reduces coupling.

## 2. Mental Model
```
Inheritance (tight)
RaceCar < Car < Vehicle
  └─ gets all parent behavior, even unwanted methods

Composition (flexible)
Car has-a Engine
Car has-a Stereo
Car has-a TireSet

Swap at runtime:
Car.new(ElectricMotor.new)
Car.new(HybridMotor.new)
```

## 3. Starter Code shown
```ruby
# frozen_string_literal: true

class Engine
  def start
    "engine on"
  end
end

class Car
  def initialize(engine)
    @engine = engine
  end
end
```

## 4. You Type This
- Implement `Car#drive` by delegating to `engine.start`.
- Add `ElectricMotor` with same API.
- Swap engines without changing Car.

## 5. Expand the Example
Add `TurboBooster` object and compose it only for race cars.

## 6. Real-World Application
Payment services use composition to swap providers (Stripe, Braintree).

## 7. Checklist (before moving on)
- [ ] I can spot has-a relationships.
- [ ] I can delegate from one object to another.
- [ ] I can swap dependencies in tests.

## 8. Common Mistakes
- Overusing inheritance for shared utility methods.
- Hiding dependencies instead of injecting them.

## 9. Debug Flow
1. Wrong behavior? inspect composed object class.
2. NoMethodError? verify composed object contract.
3. Hard to test? inject dependency via initializer.

## 10. Stretch Goal + sample output
Create a `NotificationService` composed with `EmailChannel` or `SmsChannel`.

Sample output:
```
driving: engine on
driving: electric on
```
