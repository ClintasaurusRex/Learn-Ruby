# frozen_string_literal: true

# Lesson 05 — Inheritance

## 1) Concept Overview
Inheritance lets a subclass reuse parent behavior.
A child class can add or override methods.
`super` calls parent implementation from child method.
Use inheritance only for true "is-a" relationships.
Prefer composition when relationships are weaker.

## 2) Mental Model
```
Inheritance chain + super flow

Animal
  speak -> "sound"
   ^
   | inherits
Dog < Animal
  speak -> super + " bark"
             |
             +--> Animal#speak returns "sound"

Call dog.speak:
Dog#speak -> super -> Animal#speak -> "sound bark"
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class Animal
  def speak
    "sound"
  end
end

class Dog < Animal
  # TODO: override speak and use super
end
```

## 4) You Type This
- Override `Dog#speak`.
- Call `super` inside override.
- Append child-specific sound text.
- Instantiate and print both animal and dog speaks.

## 5) Expand the Example
Add `Cat < Animal` and give it its own `speak` output.
Keep shared base behavior in parent class.
Then show both classes share ancestry but differ in behavior.

## 6) Real-World Application
Framework base classes provide default behavior.
Your subclass overrides only pieces it needs.
`super` keeps shared setup logic without duplication.

## 7) Checklist (before moving on)
- [ ] I can define a subclass with `<`.
- [ ] I know when overriding is appropriate.
- [ ] I can use `super` correctly.
- [ ] I can explain method lookup in inheritance.
- [ ] I can identify bad inheritance fit.

## 8) Common Mistakes
- Overriding without calling `super` when parent behavior is required.
- Creating inheritance just to reuse code without "is-a" relation.
- Deep inheritance trees that are hard to reason about.

## 9) Debug Flow
- Wrong method used? Check `object.class.ancestors`.
- Missing parent behavior? Confirm `super` call exists.
- Unexpected output? Print inside parent and child methods.

## 10) Stretch Goal + sample output
Add `Bird < Animal` where `speak` returns `"sound chirp"`.

Sample output:
```
sound
sound bark
sound meow
```
