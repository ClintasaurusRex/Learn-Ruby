# Lesson 12 — Rails API Mode

## 1) Concept Overview
API mode focuses on JSON endpoints. Controllers parse request data, run business logic, and render structured JSON responses.

## 2) Mental Model
```
API request/response cycle

Client -> HTTP request -> Router -> Controller -> Model/Service
      <- JSON response <- Serializer <- Data

JSON serialization flow

Domain object -> serializer -> hash -> JSON string -> response body
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

def serialize_user(user)
  # TODO: return hash with :id and :name
end
```

## 4) You Type This
- Open `starter.rb`.
- Implement serializer hash.
- Convert to JSON string.
- Print status and body.

## 5) Expand the Example
Add error payloads with `errors` array and HTTP status mapping for validation failures.

## 6) Real-World Application
Use API mode for mobile backends, SPA backends, and third-party integrations.

## 7) Checklist (before moving on)
- [ ] I know request lifecycle in API mode.
- [ ] I can build deterministic JSON payloads.
- [ ] I can separate domain from serializer logic.
- [ ] I can include errors in response shape.
- [ ] I can keep versioned routes stable.

## 8) Common Mistakes
- Rendering domain objects directly without serialization.
- Inconsistent response envelopes.
- Missing error contracts.

## 9) Debug Flow
- Inspect parsed params.
- Verify serializer keys.
- Compare JSON output to API contract.

## 10) Stretch Goal + sample output
Add versioned envelope: `{ meta: { version: 'v1' }, data: ... }`.

Sample output:
```
Status: 200
Body: {"id":1,"name":"Ari"}
```
