# Lesson 14 — Refactor and Patterns

## 1) Concept Overview
Refactoring improves structure without changing behavior. In Rails, common patterns include service objects, concerns, and decorators.

## 2) Mental Model
```
Before/After refactor

Before: Fat model/controller with mixed responsibilities
  Order -> validates + charges + emails + formats UI text

After: Focused objects
  Order model: persistence + core invariants
  ChargeOrder service: payment workflow
  Notifiable concern: shared notification behavior
  OrderDecorator: presentation formatting

Pattern decision diagram

Need orchestration? -> Service object
Need shared model behavior? -> Concern
Need presentation-only formatting? -> Decorator
Else keep in model/controller if simple
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class Order
  def checkout(total_cents)
    # TODO: extract charging logic to service object
  end
end
```

## 4) You Type This
- Open `starter.rb`.
- Move checkout payment logic into `ChargeOrder` service.
- Add decorator for formatted total.
- Print before/after behavior equality.

## 5) Expand the Example
Add a concern for reusable notification behavior shared by `Order` and `Invoice`.

## 6) Real-World Application
Use these patterns to reduce long models/controllers and improve testability when business rules grow.

## 7) Checklist (before moving on)
- [ ] I can explain behavior-preserving refactor.
- [ ] I know when to use a service object.
- [ ] I know when to use a concern.
- [ ] I know when to use a decorator.
- [ ] I can choose the simplest sufficient pattern.

## 8) Common Mistakes
- Extracting too early for tiny code.
- Using concerns as dumping grounds.
- Putting business logic in decorators.

## 9) Debug Flow
- Lock behavior with tests before refactor.
- Extract one responsibility at a time.
- Compare outputs before/after extraction.

## 10) Stretch Goal + sample output
Refactor a second workflow (refund) using the same service pattern.

Sample output:
```
Charged order total: 2599
Formatted total: $25.99
Decision for :orchestration => service_object
```
