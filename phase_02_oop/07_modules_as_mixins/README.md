# frozen_string_literal: true

# Lesson 07 — Modules as Mixins

## 1. Concept Overview
Modules let you share behavior without deep inheritance trees.
`include` adds instance methods.
`extend` adds class methods.
`prepend` lets a module wrap/override class behavior first.
Mixins keep responsibilities small and reusable.

## 2. Mental Model
```
include vs extend

module Trackable
  def instance_ping; "instance" end
end

class User
  include Trackable   # User.new.instance_ping
  extend Trackable    # User.instance_ping
end

Method lookup layering

[User class method]
      ↓
[PrependedModule]   (runs first)
      ↓
[User]
      ↓
[IncludedModuleA]
      ↓
[IncludedModuleB]
      ↓
[Object]
```

## 3. Starter Code shown
```ruby
# frozen_string_literal: true

module Slugifiable
  def slug
    title.downcase.gsub(/\s+/, "-")
  end
end

class Article
  include Slugifiable
  attr_reader :title

  def initialize(title)
    @title = title
  end
end
```

## 4. You Type This
- Add `ClassLabel` module and use `extend`.
- Add a prepended module that uppercases `title`.
- Verify ancestors order with `puts LoudArticle.ancestors`.

## 5. Expand the Example
Add a second mixin `Taggable` and combine output from both modules.

## 6. Real-World Application
Rails concerns are mixins: `Auditable`, `Publishable`, `Searchable`.

## 7. Checklist (before moving on)
- [ ] I can explain include vs extend.
- [ ] I can use prepend to wrap methods safely.
- [ ] I can read `.ancestors` output.

## 8. Common Mistakes
- Including module when you needed class methods.
- Forgetting `super` in prepended methods.

## 9. Debug Flow
1. Missing method? Check `.ancestors`.
2. Wrong receiver? instance vs class method.
3. Wrapped method broken? verify `super` call.

## 10. Stretch Goal + sample output
Build `Timestamped` mixin used by two unrelated classes.

Sample output:
```
article-patterns
ARTICLE PATTERNS
Article
```
