# Lesson 13 — Testing with RSpec

## 1) Concept Overview
RSpec helps you test behavior at multiple levels: fast unit tests, request tests for endpoints, and system tests for full user flows.

## 2) Mental Model
```
Test pyramid

       /\
      /  \   System specs (few, expensive)
     /----\
    /      \ Request specs (some)
   /--------\
  /          \ Model/unit specs (many, fast)
 /____________\

Examples:
- model spec: validations/business logic
- request spec: status + JSON/body contract
- system spec: user clicks through feature
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

def valid_order_total?(subtotal, tax)
  # TODO: return true when total is positive
end
```

## 4) You Type This
- Open `starter.rb`.
- Add one pure function for model-like logic.
- Write expectations in `test_lesson.rb`.
- Keep examples deterministic.

## 5) Expand the Example
Add request-level payload checks and a high-level scenario list for a system spec.

## 6) Real-World Application
Keep most tests in model/unit level for speed; add request/system only for integration-critical behavior.

## 7) Checklist (before moving on)
- [ ] I can explain the test pyramid.
- [ ] I can write deterministic unit tests.
- [ ] I can verify API response shape in request specs.
- [ ] I can define system-level acceptance flow.
- [ ] I can avoid brittle test setup.

## 8) Common Mistakes
- Too many system tests for simple logic.
- Testing implementation details instead of behavior.
- Sharing mutable state across examples.

## 9) Debug Flow
- Re-run failing spec with focused example.
- Compare expected vs actual values.
- Isolate setup data per test.

## 10) Stretch Goal + sample output
Convert one request example into a shared example block for repeated response contracts.

Sample output:
```
Model spec pass? true
Request spec pass? true
System spec scenario count: 2
```
