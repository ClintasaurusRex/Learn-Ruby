# frozen_string_literal: true

# Lesson 13 — OOP Refactor Challenge

## 1. Concept Overview
You will refactor a procedural checkout script into clean OOP objects.
Start from messy globals and long methods.
Extract responsibilities into focused classes.
The result should be easier to test and extend.
Refactoring is incremental, not all-at-once.

## 2. Mental Model
```
Before (procedural)
main script
  ├─ arrays/hashes everywhere
  ├─ tax logic inline
  ├─ print + math mixed together
  └─ difficult to test

After (OOP)
CartItem -> data
Cart -> subtotal
CheckoutService -> tax + total
Receipt -> output formatting
```

## 3. Starter Code shown
```ruby
items = [{ name: "Book", price: 12.0, qty: 2 }]
subtotal = items.sum { |i| i[:price] * i[:qty] }
```

## 4. You Type This
- Create `CartItem` class.
- Move subtotal logic into `Cart`.
- Move tax and total logic into `CheckoutService`.

## 5. Expand the Example
Add discount policies as separate objects (composition).

## 6. Real-World Application
Legacy scripts are commonly migrated this way in production codebases.

## 7. Checklist (before moving on)
- [ ] I can identify mixed responsibilities.
- [ ] I can extract behavior into classes safely.
- [ ] I can preserve output while changing structure.

## 8. Common Mistakes
- Refactoring and changing behavior at the same time.
- Leaving business rules duplicated in multiple places.

## 9. Debug Flow
1. Keep before/after outputs side-by-side.
2. Add tests around expected totals first.
3. Move one responsibility at a time.

## 10. Stretch Goal + sample output
Add `TaxPolicy` and `DiscountPolicy` objects into CheckoutService.

Sample output:
```
subtotal: 30.0
tax: 3.0
total: 33.0
```
