# frozen_string_literal: true

# Lesson 12 — OOP Design Principles

## 1. Concept Overview
SOLID principles help classes stay small, flexible, and testable.
Use them to avoid fragile code and giant "god objects".
Each principle is a practical design lens.
You do not need perfection—just steady direction.
Use plain boundaries and clear contracts.

## 2. Mental Model
```
S — Single Responsibility
[Invoice] -> computes totals
[InvoicePrinter] -> prints output

O — Open/Closed
[Checkout] uses [TaxPolicy interface]
add [USTax], [EUTax] without editing Checkout

L — Liskov Substitution
[Gateway#charge]
  ↑
[StripeGateway], [FakeGateway] both substitutable

I — Interface Segregation
[Notifier] tiny API: #deliver(message)
avoid huge multi-method interfaces

D — Dependency Inversion
[Checkout] depends on Notifier abstraction
not concrete EmailNotifier class
```

## 3. Starter Code shown
```ruby
class Checkout
  def initialize(gateway)
    @gateway = gateway
  end
end
```

## 4. You Type This
- Split pricing, tax, and printing responsibilities.
- Inject dependencies by constructor.
- Add new policy classes without editing core workflow.

## 5. Expand the Example
Add `WeekendDiscountPolicy` object and plug it into checkout.

## 6. Real-World Application
Teams use SOLID to keep feature changes local and safe.

## 7. Checklist (before moving on)
- [ ] I can explain each SOLID principle in plain language.
- [ ] I can inject dependencies instead of hardcoding them.
- [ ] I can add new behavior by adding classes.

## 8. Common Mistakes
- Over-abstraction too early.
- Confusing interface segregation with creating many tiny files.

## 9. Debug Flow
1. Big class doing too much? split responsibilities.
2. Change requires editing old class repeatedly? apply OCP.
3. Hard to test external side effects? inject dependencies.

## 10. Stretch Goal + sample output
Implement a `Checkout` that accepts pluggable tax and notifier policies.

Sample output:
```
charged 11.0
receipt total: 11.0
```
