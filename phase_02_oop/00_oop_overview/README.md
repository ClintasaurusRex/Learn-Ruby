# frozen_string_literal: true

# Lesson 00 — OOP Overview

## 1) Concept Overview
OOP groups data and behavior into objects.
A class is a blueprint; objects are concrete instances.
Objects carry state and expose methods that act on that state.
This structure helps avoid fragile global data flow.
Use OOP when behavior naturally belongs to a "thing".

## 2) Mental Model
```
Why OOP exists:

procedural style
  users_hash[id][:name] + users_hash[id][:status]
  (data + behavior spread everywhere)

OOP style

      Class (Blueprint)
      +----------------------+
      | User                 |
      | - @name              |
      | - @status            |
      | + active?            |
      +----------+-----------+
                 |
         creates |
                 v
      Object (Instance)
      +----------------------+
      | #<User:0x001 ...>    |
      | @name="Ava"          |
      | @status="active"     |
      +----------------------+

Message: user.active? -> behavior uses object state.
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class User
  attr_reader :name, :status

  def initialize(name, status)
    @name = name
    @status = status
  end

  def active?
    status == "active"
  end

  # TODO: add archived? method
  # Hint: status == "archived"
end
```

## 4) You Type This
- Open `starter.rb`.
- Add the `archived?` method.
- Create one active user and one archived user.
- Print both checks with `puts`.

## 5) Expand the Example
Turn a plain `Hash` user record into a `User` object.
Then move status checks from free functions into instance methods.
Notice how call sites become `user.active?` instead of passing hashes around.

## 6) Real-World Application
In apps, models like `Order`, `Invoice`, or `Account` are objects.
State (attributes) and behavior (methods) live together.
That improves readability and local reasoning when business rules change.

## 7) Checklist (before moving on)
- [ ] I can explain class vs object.
- [ ] I can explain state vs behavior.
- [ ] I can instantiate an object with `new`.
- [ ] I can call an instance method.
- [ ] I can explain why OOP reduces scattered logic.

## 8) Common Mistakes
- Treating classes as objects you can read state from directly.
- Storing all data externally and never using instance variables.
- Creating giant classes with unrelated behavior.

## 9) Debug Flow
- Wrong output? `p object.inspect` to view state.
- Method missing? Check method name and receiver (`object.method`).
- State nil? Confirm `initialize` sets every required instance variable.

## 10) Stretch Goal + sample output
Add `suspended?` status handling and a `status_label` method.

Sample output:
```
Ava active? true
Noah archived? true
Noah status label: archived
```
