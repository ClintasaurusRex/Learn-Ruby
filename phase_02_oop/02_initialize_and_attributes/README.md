# frozen_string_literal: true

# Lesson 02 — initialize and attributes

## 1) Concept Overview
`initialize` runs when `new` creates an object.
Use it to set initial instance variable state.
Attributes expose object state via readers/writers.
`attr_reader` gives read access; `attr_accessor` gives read/write.
Good initialization prevents nil surprises later.

## 2) Mental Model
```
Object state lifecycle

new("Ruby", 300)
      |
      v
initialize(title, pages)
  @title = "Ruby"
  @pages = 300
      |
      v
book object state
+------------------+
| @title="Ruby"    |
| @pages=300       |
+------------------+
      |
      +--> book.title  # read
      +--> book.pages=350  # write (if accessor)
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class Book
  attr_reader :title
  attr_accessor :pages

  def initialize(title, pages)
    @title = title
    @pages = pages
  end

  # TODO: add summary method
  # Hint: "#{title} (#{pages} pages)"
end
```

## 4) You Type This
- Add `summary` method.
- Instantiate one book.
- Read `title` and `pages`.
- Update `pages` and print updated summary.

## 5) Expand the Example
Add a new attribute `author`.
Initialize all attributes through constructor args.
Then expose only `title` and `author` with readers if `pages` should stay mutable.

## 6) Real-World Application
API objects and model objects are initialized with state once.
Attribute access controls which fields callers can read or write.
This keeps invariants safer and object behavior predictable.

## 7) Checklist (before moving on)
- [ ] I know when `initialize` runs.
- [ ] I can set instance variables in `initialize`.
- [ ] I can use `attr_reader` and `attr_accessor`.
- [ ] I can update mutable attributes safely.
- [ ] I can print object state in a method.

## 8) Common Mistakes
- Forgetting to assign constructor args to instance variables.
- Using local variables in place of instance variables.
- Exposing too many writable attributes.

## 9) Debug Flow
- Value is nil? Check constructor argument order.
- Writer missing? Verify `attr_accessor` is declared.
- Wrong output? Print `p [title, pages]` inside summary.

## 10) Stretch Goal + sample output
Validate pages is always positive in `initialize`.

Sample output:
```
Ruby Fundamentals (300 pages)
Ruby Fundamentals (350 pages)
```
