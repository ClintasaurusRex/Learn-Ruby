# frozen_string_literal: true

# Lesson 10 — Comparable and Enumerable

## 1. Concept Overview
`Comparable` gives rich comparisons from one `<=>` method.
`Enumerable` gives collection helpers from one `each` method.
Both are mixins that multiply power from tiny contracts.
Implement one method correctly and gain many methods for free.
Think "small interface, big capability".

## 2. Mental Model
```
Score includes Comparable
  implements: <=>
  gains: < <= == > >= between? sort min max

WordList includes Enumerable
  implements: each
  gains: map select reject any? all? count find

Comparable + Enumerable = module integration by contracts
```

## 3. Starter Code shown
```ruby
class Score
  include Comparable
  def <=>(other)
    points <=> other.points
  end
end
```

## 4. You Type This
- Implement `<=>` in `Score`.
- Implement `each` in `WordList`.
- Use `sort`, `map`, and `select` with no extra methods.

## 5. Expand the Example
Create `TaskList` with `Enumerable` and filter completed tasks.

## 6. Real-World Application
Ruby's `Range`, `Array`, and many gems rely on these same contracts.

## 7. Checklist (before moving on)
- [ ] I can implement `<=>` correctly.
- [ ] I can write a yielding `each` method.
- [ ] I can explain why `sort` suddenly works.

## 8. Common Mistakes
- Returning non -1/0/1/nil style values from `<=>`.
- Forgetting to return an Enumerator when no block is provided.

## 9. Debug Flow
1. Compare returns nil? check type compatibility.
2. Enumerable methods fail? verify `each` yields values.
3. Map/select empty? inspect yielded element values.

## 10. Stretch Goal + sample output
Build `PriorityTask` including Comparable and sort tasks by urgency.

Sample output:
```
true
["ALPHA", "BETA"]
```
