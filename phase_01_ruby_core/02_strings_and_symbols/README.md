# Lesson 02 — Strings and Symbols

---

## 1) Concept Overview

Strings are mutable sequences of characters you use for human-readable text.
Symbols are immutable, memory-efficient identifiers used as labels, keys, and method names.
Ruby provides 10+ built-in string methods for slicing, searching, and transforming text.
Heredocs let you write multi-line strings cleanly without escaped newlines.
`Symbol#to_proc` (`&:upcase`) is a shorthand that turns any symbol into a callable block.

---

## 2) Mental Model Diagram

```
STRING                           SYMBOL
───────────────────────          ───────────────────────
"hello"                          :hello
 │                                │
 ├─ mutable (chars can change)    ├─ immutable (frozen forever)
 ├─ every "hello" is a NEW obj    ├─ only ONE :hello exists in memory
 ├─ great for user-facing text    ├─ great for hash keys, method refs
 └─ has dozens of methods         └─ converts to string with .to_s

STRING METHODS (chain them!)
──────────────────────────────────────────────────────
"  Hello, World!  "
  .strip          => "Hello, World!"
  .downcase       => "hello, world!"
  .gsub(",", "")  => "hello world!"
  .split(" ")     => ["hello", "world!"]
  .map(&:capitalize)          => ["Hello", "World!"]
  .join(" ")      => "Hello World!"

SYMBOL → PROC  (&:upcase)
──────────────────────────────────────────────────────
:upcase.to_proc          => #<Proc:...>
["a","b"].map(&:upcase)  ≡  ["a","b"].map { |s| s.upcase }
                         => ["A", "B"]

HEREDOC (multi-line string)
──────────────────────────────────────────────────────
puts <<~TEXT
  Line one
  Line two
TEXT
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

message = "  Hello, Ruby World!  "

# String methods
puts message.strip                      # => "Hello, Ruby World!"
puts message.strip.upcase               # => "HELLO, RUBY WORLD!"
puts message.strip.split(", ").inspect  # => ["Hello", "Ruby World!"]

# Checking content
puts message.include?("Ruby")           # => true
puts message.strip.start_with?("Hello") # => true
puts message.strip.gsub("Ruby", "Crystal") # => "Hello, Crystal World!"

# Symbols
status = :active
puts status           # => active
puts status.class     # => Symbol
puts status.to_s      # => "active"

# Heredoc
puts <<~GREETING
  Welcome to the lesson.
  Today we cover strings and symbols.
GREETING
```

---

## 4) You Type This

Open `starter.rb` and complete the TODOs. Then try:

1. Call `.chars` on a string and count vowels using `.select`.
2. Use `.scan(/\w+/)` to extract all words from a sentence.
3. Write a method that checks if a word is a palindrome.
4. Turn an array of symbols `[:name, :age, :email]` into strings using `map(&:to_s)`.
5. Use `&:reverse` to reverse every string in an array.

---

## 5) Expand the Example

**String interpolation vs concatenation:**

```ruby
name = "Alice"

# Interpolation (preferred — calls .to_s automatically)
puts "Hello, #{name}!"          # => Hello, Alice!

# Concatenation (requires strings)
puts "Hello, " + name + "!"    # => Hello, Alice!
```

**Useful string methods:**

```ruby
s = "Ruby programming"

puts s.length           # => 16
puts s.count("r")       # => 2  (case-sensitive)
puts s.index("p")       # => 5
puts s.slice(0, 4)      # => "Ruby"
puts s[5..]             # => "programming"
puts s.center(20, "-")  # => "--Ruby programming--"
puts s.ljust(20, ".")   # => "Ruby programming...."
puts s.tr("aeiou", "*") # => "R*by pr*gr*mm*ng"
puts s.squeeze("m")     # => "Ruby programing"
```

**When to use Symbol vs String:**

```ruby
# Symbol as hash key (preferred for known, fixed keys)
user = { name: "Alice", role: :admin }
puts user[:name]   # => Alice

# String when content is dynamic or external
input = gets.chomp          # user types something
puts input.class            # => String

# Convert between them
puts :hello.to_s            # => "hello"
puts "hello".to_sym         # => :hello
puts :hello == :hello       # => true (same object)
puts "hello".equal?("hello") # => false (different objects)
```

---

## 6) Real-World Application

> *"How would you use this at work?"*

- **String methods** — sanitize and normalize user input before saving to a database.
- **Heredocs** — embed SQL queries or HTML snippets in Ruby code without escaping.
- **Symbols as hash keys** — Rails uses them everywhere: `params[:user]`, `render json: { status: :ok }`.
- **`&:method`** — `users.map(&:email)`, `orders.select(&:paid?)`, `words.map(&:upcase)` — daily Rails patterns.

```ruby
# Real-world: normalize a list of user-submitted tags
raw_tags = ["  Ruby ", "rails", "RUBY", " JavaScript  "]

cleaned = raw_tags
  .map(&:strip)
  .map(&:downcase)
  .uniq
  .sort

puts cleaned.inspect
# => ["javascript", "rails", "ruby"]

# Real-world: build a slug from a page title
title = "  My Awesome Blog Post!  "
slug  = title.strip.downcase.gsub(/[^a-z0-9]+/, "-").delete_suffix("-")
puts slug   # => "my-awesome-blog-post"
```

---

## 7) Checklist

Before moving on, confirm you can:

- [ ] Call at least 10 string methods and explain what each returns
- [ ] Use string interpolation with `#{expression}`
- [ ] Format strings with `.center`, `.ljust`, `.rjust`
- [ ] Write a heredoc with `<<~HEREDOC` and explain why `~` strips indentation
- [ ] Explain the difference between a Symbol and a String
- [ ] State why symbols are preferred as hash keys
- [ ] Convert between String and Symbol with `.to_sym` / `.to_s`
- [ ] Use `&:method_name` as a shorthand block in `map`, `select`, `reject`
- [ ] Explain what `Symbol#to_proc` does under the hood
- [ ] Write a palindrome checker using string methods

---

## 8) Common Mistakes

| Mistake | Fix |
|---------|-----|
| `str.upcase!` on a frozen string literal | Use `str.upcase` (non-bang) or `str.dup.upcase!` |
| `"hello" == :hello` expecting true | They are never equal — use `.to_s` or `.to_sym` to convert first |
| Using string keys for hashes when symbols are clearer | Prefer `{ name: "Alice" }` over `{ "name" => "Alice" }` for fixed keys |
| Forgetting `~` in `<<~HEREDOC` | Without `~`, leading spaces are included in the string |
| `split` with no argument splits on whitespace; `split("")` splits on every char | Know which one you need |
| Chaining `.strip.downcase` vs `.downcase.strip` | Order matters when chaining — think about what each step returns |
| `str.replace` mutates the receiver — unsafe on frozen literals | Use `str.dup.replace(...)` or just reassign with `str = new_value` |

---

## 9) Debug Flow

```
Getting FrozenError on a string?
  └─ You have `# frozen_string_literal: true` at the top
  └─ Use non-bang methods: .upcase instead of .upcase!
  └─ Or dup the string first: str.dup.upcase!

Symbol and String not matching?
  └─ puts my_var.class  # Is it Symbol or String?
  └─ Convert: my_var.to_s  or  my_var.to_sym

split giving unexpected results?
  └─ puts str.inspect  # see exact chars including spaces
  └─ Try .split(" ") vs .split  vs .split("")

Heredoc showing wrong indentation?
  └─ Use <<~HEREDOC (squiggly heredoc strips leading whitespace)
  └─ Make sure the closing HEREDOC is on its own line

map(&:method_name) giving NoMethodError?
  └─ Check the element type: puts arr.first.class
  └─ Make sure the method exists on that type
  └─ Example: &:upcase only works on String, not Integer
```

---

## 10) Stretch Goal

Build a **text statistics** analyzer that handles a full paragraph:

```ruby
text = <<~PARAGRAPH
  Ruby is a dynamic, open source programming language with a focus on
  simplicity and productivity. It has an elegant syntax that is natural
  to read and easy to write.
PARAGRAPH

words      = text.split
sentences  = text.split(/[.!?]/).map(&:strip).reject(&:empty?)
word_freq  = words.map(&:downcase).tally.sort_by { |_, v| -v }.first(5)

puts "Words:        #{words.length}"
puts "Sentences:    #{sentences.length}"
puts "Avg word len: #{words.map(&:length).sum.to_f / words.length}"
puts "Top 5 words:  #{word_freq.map { |w, c| "#{w}(#{c})" }.join(", ")}"
```

Sample output:
```
Words:        30
Sentences:    3
Avg word len: 4.8
Top 5 words:  a(3), ruby(1), is(2), and(2), that(1)
```

Extend it: add a method that counts unique words and reports the longest word.
