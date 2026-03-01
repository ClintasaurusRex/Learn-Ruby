# Lesson 09 — ActiveRecord Validations

## 1) Concept Overview
Validations prevent invalid records from being saved. They run before persistence and collect errors for display.

## 2) Mental Model
```
Validation flow

input -> model.assign_attributes
      -> valid?
      -> run validators
      -> errors.empty?
          yes -> save
          no  -> halt save

Error bubble-up flow

Validator -> model.errors[:field]
         -> controller checks save result
         -> view renders error messages near fields
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class Signup
  attr_reader :email, :errors

  def initialize(email)
    @email = email
    @errors = []
  end

  def valid?
    # TODO: push an error when email is blank
  end
end
```

## 4) You Type This
- Open `starter.rb`.
- Add presence and format checks.
- Keep all errors in an array.
- Print validation result and errors.

## 5) Expand the Example
Add a password length check and a username uniqueness check against in-memory records.

## 6) Real-World Application
In Rails, use validations to protect business rules close to the model layer so every entry point (web, console, job) gets the same checks.

## 7) Checklist (before moving on)
- [ ] I know when validations run.
- [ ] I can use presence and format checks.
- [ ] I can inspect `errors` after `valid?`.
- [ ] I can explain why failed save returns false.
- [ ] I can surface errors in the UI.

## 8) Common Mistakes
- Validating only in controllers.
- Forgetting to clear previous errors.
- Using exceptions for normal invalid input.

## 9) Debug Flow
- Call `valid?` and inspect errors.
- Print each field value before checking.
- Verify condition order so specific errors are not masked.

## 10) Stretch Goal + sample output
Add conditional validation: require company name when account type is `business`.

Sample output:
```
Valid? false
Errors: Email can't be blank, Email format is invalid
```
