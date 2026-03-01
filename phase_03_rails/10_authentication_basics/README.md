# Lesson 10 — Authentication Basics (`has_secure_password`)

## 1) Concept Overview
Authentication verifies identity. In Rails basics, `has_secure_password` uses BCrypt to hash passwords and authenticate users without storing plain text.

## 2) Mental Model
```
Auth flow (no Devise)

Sign up:
email + password
   -> has_secure_password
   -> password_digest stored

Login:
email + password attempt
   -> find user by email
   -> authenticate(password)
      -> true  => create session
      -> false => reject login
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class Account
  attr_reader :email, :password_digest

  def initialize(email, password)
    @email = email
    # TODO: digest password (simulated)
  end
end
```

## 4) You Type This
- Open `starter.rb`.
- Add a digest function (simulated in plain Ruby).
- Add `authenticate` method.
- Print success/failure login attempts.

## 5) Expand the Example
Add session storage with an in-memory hash and implement logout by deleting session key.

## 6) Real-World Application
In Rails apps, use `has_secure_password` for small/medium apps when full auth frameworks are unnecessary.

## 7) Checklist (before moving on)
- [ ] I know never to store plain passwords.
- [ ] I can explain password digesting.
- [ ] I can verify credentials with `authenticate`.
- [ ] I can describe a login session lifecycle.
- [ ] I can explain why Devise is not required for basics.

## 8) Common Mistakes
- Saving password in plain text.
- Comparing raw input against digest directly.
- Forgetting session reset on logout.

## 9) Debug Flow
- Verify user lookup by email first.
- Check that digest function is deterministic for same input.
- Ensure failed login does not set session.

## 10) Stretch Goal + sample output
Add account lock after 3 failed attempts and reset on success.

Sample output:
```
Login success? true
Login success? false
```
