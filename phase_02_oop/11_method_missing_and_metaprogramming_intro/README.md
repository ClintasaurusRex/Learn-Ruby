# frozen_string_literal: true

# Lesson 11 — Method Missing and Metaprogramming Intro

## 1. Concept Overview
`method_missing` catches unknown method calls.
Use it carefully and keep behavior explicit and safe.
Pair it with `respond_to_missing?` for introspection correctness.
Prefer simple, predictable patterns over clever magic.
This lesson uses dynamic config getters/setters.

## 2. Mental Model
```
call: config.api_key=("abc")
        ↓
Ruby cannot find method
        ↓
method_missing receives :api_key=
        ↓
store key/value in @settings hash
        ↓
later call config.api_key
        ↓
method_missing returns stored value
```

## 3. Starter Code shown
```ruby
class SafeConfig
  def method_missing(name, *args)
    # parse key and set/get from hash
  end
end
```

## 4. You Type This
- Support dynamic writer methods ending with `=`.
- Support matching readers.
- Implement `respond_to_missing?`.

## 5. Expand the Example
Add `fetch(key, default=nil)` helper for explicit safe reads.

## 6. Real-World Application
ORMs and API clients use metaprogramming to reduce boilerplate.

## 7. Checklist (before moving on)
- [ ] I can explain when method_missing runs.
- [ ] I can pair it with respond_to_missing?.
- [ ] I can avoid unsafe eval-based metaprogramming.

## 8. Common Mistakes
- Swallowing all unknown methods without calling `super`.
- Forgetting `respond_to_missing?`.

## 9. Debug Flow
1. Weird NoMethodError? inspect method symbol in `method_missing`.
2. `respond_to?` false unexpectedly? fix `respond_to_missing?`.
3. Unexpected key values? inspect normalized key names.

## 10. Stretch Goal + sample output
Support nested keys like `config.db_host = "localhost"`.

Sample output:
```
abc123
true
```
