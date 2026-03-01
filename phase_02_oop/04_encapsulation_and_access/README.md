# frozen_string_literal: true

# Lesson 04 — Encapsulation and access control

## 1) Concept Overview
Encapsulation hides internal details behind a clean public API.
Ruby access levels are `public`, `protected`, and `private`.
Public methods are callable from anywhere.
Private methods are callable only without explicit receiver inside object context.
Use access control to protect invariants.

## 2) Mental Model
```
Access boundaries

Outside caller
    |
    | can call
    v
+---------------------------------+
| public: deposit, balance        |
| --------------------------------|
| protected: comparable_balance?  |
| --------------------------------|
| private: validate_amount        |
+---------------------------------+
    ^
    | cannot call directly from outside:
    | account.validate_amount(10)  # NoMethodError
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class Wallet
  def initialize(amount)
    @amount = amount
  end

  def add(amount)
    validate_amount(amount)
    @amount += amount
  end

  private

  # TODO: ensure amount is positive
  def validate_amount(amount)
  end
end
```

## 4) You Type This
- Implement `validate_amount`.
- Keep method private.
- Add a public reader for current amount.
- Try calling private method directly and observe error.

## 5) Expand the Example
Add a protected method to compare two wallet balances.
Call it from another wallet instance method.
Observe it works between instances but not from outside.

## 6) Real-World Application
Payment classes hide validation internals.
Controllers/services call public methods only.
This limits accidental misuse and centralizes rules.

## 7) Checklist (before moving on)
- [ ] I can describe encapsulation.
- [ ] I know when to use private methods.
- [ ] I understand protected vs private intent.
- [ ] I can expose only safe public methods.
- [ ] I can keep validation logic internal.

## 8) Common Mistakes
- Making helper methods public accidentally.
- Calling private methods with explicit receiver.
- Exposing writable attributes that break invariants.

## 9) Debug Flow
- Unexpected access? Check method visibility with `public_methods(false)`.
- `NoMethodError` on private call? Remove explicit receiver.
- Invariant broken? Move checks into private validator.

## 10) Stretch Goal + sample output
Raise custom `InvalidAmountError` from private validator.

Sample output:
```
Balance: 30
Add failed: amount must be positive
```
