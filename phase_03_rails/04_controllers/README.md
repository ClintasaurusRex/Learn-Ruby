# Lesson 04 — Controllers

---

## 1) Concept Overview

Controllers receive requests, gather data, and choose a response (`render` or `redirect_to`).
They should stay thin: orchestration logic, not deep business rules.

---

## 2) Mental Model Diagram

### Controller anatomy diagram (required)

```
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index   ; end
  def show    ; end
  def create  ; end
  def update  ; end
  def destroy ; end

  private

  def set_post ; end
  def post_params ; end
end
```

### before_action flow (required)

```
Request -> Controller Action Requested
            |
            v
      before_action callbacks
            |
            +--> halt/redirect? -> response ends
            |
            v
        action method runs
            |
            v
       render/redirect response
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# class PostsController < ApplicationController
#   before_action :set_post, only: %i[show]
#
#   def show
#     render :show
#   end
# end
```

---

## 4) You Type This

1. Add a `before_action` for auth.
2. Add strong params method.
3. Keep controller private methods organized.

---

## 5) Expand the Example

Add `index` and `create` actions and handle success/failure branches clearly.

---

## 6) Real-World Application

Controller consistency makes onboarding easier and bug triage faster.

---

## 7) Checklist

- [ ] I can explain controller responsibility.
- [ ] I can use `before_action`.
- [ ] I can use strong parameters.
- [ ] I can choose render vs redirect.

---

## 8) Common Mistakes

| Mistake | Fix |
|---|---|
| Heavy business logic in controller | Extract to model/service |
| Missing strong params | Use `params.require(...).permit(...)` |
| Duplicate setup code | Move into before_action |

---

## 9) Debug Flow

```
Action not reached?
  -> check route + action name
Filter blocking unexpectedly?
  -> inspect before_action order and conditions
Params missing?
  -> log permitted params in development
```

---

## 10) Stretch Goal

Create a controller with index/show/create and extract repeated code into private methods.
