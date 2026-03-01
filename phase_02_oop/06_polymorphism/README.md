# frozen_string_literal: true

# Lesson 06 — Polymorphism

## 1) Concept Overview
Polymorphism means one message, many implementations.
Different object types respond to the same method name.
Callers rely on interface, not concrete class details.
This reduces conditional branching on object type.
It improves extensibility when new types are added.

## 2) Mental Model
```
Same message, different behavior

send :render
   |
   +--> TextMessage#render  -> "TEXT: hello"
   +--> EmailMessage#render -> "EMAIL: hello"
   +--> PushMessage#render  -> "PUSH: hello"

Caller code:
messages.each { |m| puts m.render }
(no if/else by class)
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class TextMessage
  def render
    "TEXT: hello"
  end
end

# TODO: add EmailMessage with same render interface
```

## 4) You Type This
- Add a second class with `render`.
- Store both message objects in one array.
- Iterate and call `render` on each.
- Observe caller never branches on class.

## 5) Expand the Example
Add `PushMessage` implementing `render` too.
Then add one formatter method that accepts any renderable object.
No changes needed to existing caller logic.

## 6) Real-World Application
Payment gateways, serializers, and notifiers use polymorphism heavily.
Each adapter implements a shared method contract.
Callers stay stable as new implementations are introduced.

## 7) Checklist (before moving on)
- [ ] I can define a shared method across different classes.
- [ ] I can call one interface on mixed object types.
- [ ] I can avoid class-based conditionals for behavior dispatch.
- [ ] I can explain duck typing in Ruby.
- [ ] I can extend behavior by adding a new class.

## 8) Common Mistakes
- Checking class with long case statements instead of sending the message.
- Inconsistent method signatures across implementations.
- Forgetting to test new implementations through shared interface.

## 9) Debug Flow
- `NoMethodError`? Ensure object responds to required method.
- Wrong behavior? Test each class implementation independently.
- Unexpected branching? Remove class checks and rely on method dispatch.

## 10) Stretch Goal + sample output
Add `SlackMessage#render` without changing loop code.

Sample output:
```
TEXT: hello
EMAIL: hello
PUSH: hello
```
