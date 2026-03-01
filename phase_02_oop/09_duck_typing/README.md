# frozen_string_literal: true

# Lesson 09 — Duck Typing

## 1. Concept Overview
Duck typing means we care about behavior, not class names.
If an object responds to required methods, it can be used.
This keeps code flexible and easy to extend.
Ruby encourages this style naturally.
Focus on contracts, not inheritance trees.

## 2. Mental Model
```
"If it quacks like a duck..."

Broadcast
  ├─ EmailNotifier    #send_message
  ├─ SmsNotifier      #send_message
  └─ PushNotifier     #send_message

Broadcast only checks: respond_to?(:send_message)
```

## 3. Starter Code shown
```ruby
class Broadcast
  def call(channel, text)
    channel.send_message(text)
  end
end
```

## 4. You Type This
- Add two notifier classes with the same method.
- Add one "different class" that still works by implementing the method.

## 5. Expand the Example
Add `SlackNotifier` with `send_message` and use it with no Broadcast changes.

## 6. Real-World Application
Background job queues pass many adapter objects with common method contracts.

## 7. Checklist (before moving on)
- [ ] I can explain behavior-based design.
- [ ] I can define and document object contracts.
- [ ] I can use `respond_to?` for safer code paths.

## 8. Common Mistakes
- Checking class equality instead of behavior.
- Forgetting to raise clear errors when contract is missing.

## 9. Debug Flow
1. NoMethodError? ensure required method exists.
2. Works for one adapter only? remove class checks.
3. Hard to extend? rely on method contract.

## 10. Stretch Goal + sample output
Create `PaymentProcessor` that accepts any object with `charge(amount)`.

Sample output:
```
email: hello
sms: hello
push: hello
```
