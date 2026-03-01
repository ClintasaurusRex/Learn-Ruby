# Lesson 02 — MVC Deep Dive

---

## 1) Concept Overview

MVC is not just folder names — it is a responsibility boundary.
Controllers orchestrate, models encapsulate domain/data rules, and views only format output.

---

## 2) Mental Model Diagram

### Detailed MVC interaction diagram (required)

```
Client Request
   |
   v
Controller Action
   |  validates params / chooses flow
   +-----------------------------+
   |                             |
   v                             v
Model Query/Command         Service Object (optional)
   |                             |
   +-------------+---------------+
                 v
            Domain Result
                 |
                 v
        View Template Rendering
                 |
                 v
             HTTP Response
```

### Where logic lives diagram (required)

```
MODEL:      validations, associations, scopes, persistence rules
CONTROLLER: request params, auth checks, render/redirect decisions
VIEW:       presentation markup, tiny display helpers

Rule of thumb:
- If it decides business meaning -> model/service
- If it decides HTTP flow      -> controller
- If it decides HTML shape     -> view
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# Controller stub:
# class OrdersController < ApplicationController
#   def create
#     # TODO: orchestrate request flow only
#   end
# end
```

---

## 4) You Type This

1. Move one business rule out of a controller into a model method.
2. Keep view free from SQL and heavy conditionals.
3. Name one case for a service object.

---

## 5) Expand the Example

Refactor a fat controller action into:
- parameter parsing,
- call to model/service,
- response handling.

---

## 6) Real-World Application

Clean boundaries make testing faster and regressions easier to isolate.
Teams can also parallelize better across controllers, models, and views.

---

## 7) Checklist

- [ ] I can classify code by layer.
- [ ] I can identify fat-controller smell.
- [ ] I can identify view logic smell.
- [ ] I can extract model/service logic safely.

---

## 8) Common Mistakes

| Mistake | Fix |
|---|---|
| Validation logic in controllers | Put in model validations |
| DB calls in views | Preload in controller/model |
| HTML strings built in model | Keep presentation in views/helpers |

---

## 9) Debug Flow

```
Bug in output?
  -> Reproduce in console/model test first
Wrong redirect?
  -> Check controller branch decisions
Unexpected SQL?
  -> Inspect model scopes and includes
```

---

## 10) Stretch Goal

Pick one existing Rails action and document each line as model/controller/view responsibility.
