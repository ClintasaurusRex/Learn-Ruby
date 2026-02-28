# Lesson 00 — Welcome to Ruby

---

## 1) Concept Overview

Ruby programs are plain text files that the Ruby interpreter reads top to bottom.
`puts` prints a value followed by a newline; `print` prints with no newline; `p` prints the raw inspect form.
String interpolation (`#{}`) embeds any Ruby expression directly inside a double-quoted string.
Comments (`#`) are ignored by the interpreter and exist purely for human readers.
IRB (Interactive Ruby) is a REPL that lets you experiment with Ruby one line at a time.

---

## 2) Mental Model Diagram

```
YOUR .rb FILE                   TERMINAL OUTPUT
─────────────────────────────   ──────────────────────────────
puts "Hello"          ──────►  Hello\n        ← newline added
print "Hello"         ──────►  Hello           ← no newline
p "Hello"             ──────►  "Hello"\n       ← quotes shown (inspect)

STRING INTERPOLATION
────────────────────────────────────────
name = "Alice"
age  = 30
"My name is #{name} and I am #{age}."
              │                │
              └─ any Ruby      └─ numbers converted to string
                 expression        automatically

COMMENTS
────────────────────────────────────────
# This entire line is ignored by Ruby
x = 42   # Inline comment — code runs, comment is skipped

RUNNING A FILE          IRB (REPL)
──────────────────────  ──────────────────────
$ ruby my_file.rb       $ irb
                        irb> 2 + 2
                        => 4
                        irb> exit
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

name = "Alice"
age  = 30

puts "Hello, #{name}!"          # => Hello, Alice!
print "Age: "
print age
print "\n"                       # manual newline after print

p name                           # => "Alice"   (with quotes)
p age                            # => 30

# This is a single-line comment
x = 10  # inline comment — x is still 10
```

---

## 4) You Type This

Open `starter.rb` and complete the TODOs. Then try:

1. Change `name` and `age` — re-run `ruby starter.rb` to see new output.
2. Use `print` three times in a row (no newlines) to put words on the same line.
3. Try `p [1, 2, 3]` vs `puts [1, 2, 3]` — notice the difference.
4. Open IRB and type `"hello".upcase` — observe the `=>` return value.
5. Add a multi-line comment block using `#` on each line.

---

## 5) Expand the Example

**puts vs print vs p — side-by-side:**

```ruby
data = [1, 2, 3]
puts data    # prints each element on its own line — no brackets
p data       # prints [1, 2, 3] — shows the real Ruby object
print data   # prints [1, 2, 3] with no trailing newline

str = "hello\tworld"
puts str     # hello	world    (tab rendered)
p str        # "hello\tworld"  (escape sequences shown)
```

**String interpolation with expressions:**

```ruby
a = 5
b = 3
puts "#{a} + #{b} = #{a + b}"    # => 5 + 3 = 8
puts "#{a > b ? 'bigger' : 'smaller'}"  # ternary inside interpolation
puts "Upcased: #{"ruby".upcase}"  # method call inside interpolation
```

**Multiline strings:**

```ruby
msg = "Line one\n" \
      "Line two\n" \
      "Line three"
puts msg
```

---

## 6) Real-World Application

> *"How would you use this at work?"*

- **puts** — log messages to the console in scripts and CLI tools.
- **p** — quick debug tool; `p my_object` shows you the exact object without any formatting surprises.
- **String interpolation** — build dynamic messages, SQL snippets, file paths, API URLs.
- **Comments** — document *why* code does something (not just what it does).
- **IRB** — explore a gem's API interactively before writing tests.

```ruby
# Real-world: build a user-facing status line
user  = "alice"
score = 42
rank  = 7

puts "Player #{user.capitalize} — Score: #{score} — Rank: ##{rank}"
# => Player Alice — Score: 42 — Rank: #7

# Debug with p during development
p score   # => 42  — clearly an Integer, not a String
```

---

## 7) Checklist

Before moving on, confirm you can:

- [ ] Run a `.rb` file from the terminal with `ruby filename.rb`
- [ ] Explain the output difference between `puts`, `print`, and `p`
- [ ] Use string interpolation with a variable: `"Hello, #{name}!"`
- [ ] Use string interpolation with an expression: `"#{2 + 2}"`
- [ ] Add a single-line comment with `#`
- [ ] Add an inline comment after code
- [ ] Open IRB, type an expression, read the `=>` result, and exit
- [ ] Explain why `p "hello"` prints `"hello"` but `puts "hello"` prints `hello`

---

## 8) Common Mistakes

| Mistake | Fix |
|---------|-----|
| `puts "Hello, " + name + "!"` — fragile concatenation | Use interpolation: `puts "Hello, #{name}!"` |
| `'Hello, #{name}'` — single quotes don't interpolate | Switch to double quotes: `"Hello, #{name}"` |
| Using `print` and forgetting the newline | Add `print "\n"` or switch to `puts` |
| `p` in production output — shows raw inspect form | Use `puts` or `pp` for user-facing output |
| Commenting out code with `#` and wondering why it changed nothing | Comments are *ignored*; the variable/value wasn't changed |
| Confusing `puts nil` (blank line) vs `p nil` (`nil`) | `p` always shows the object; `puts nil` prints an empty line |

---

## 9) Debug Flow

```
Nothing printed?
  └─ Check that you saved the file before running
  └─ Make sure you ran `ruby filename.rb` (not just pressed enter in IRB)

Output looks wrong?
  └─ Switch from puts to p temporarily — see the raw value
  └─ p my_variable  # shows type AND value

Interpolation not working?
  └─ Check: are you using double quotes "..." not single quotes '...'?
  └─ Check: the expression is inside #{ } not just { }

Syntax error on a comment line?
  └─ The # must come before any code on that line (inline: after the code)
  └─ Multi-line strings that accidentally include # can be tricky — use p to inspect

IRB not found?
  └─ Run `gem install irb` or check Ruby is installed: `ruby -v`
```

---

## 10) Stretch Goal

Build a small **formatted reporter** that demonstrates all output methods:

```ruby
# frozen_string_literal: true

def report(label, value)
  puts "-" * 30
  puts "Label : #{label}"
  puts "Value : #{value}"
  print "Inspect: "
  p value
end

report("Greeting", "Hello, World!")
report("Pi",        3.14159)
report("List",      [1, 2, 3])
```

Expected output:

```
------------------------------
Label : Greeting
Value : Hello, World!
Inspect: "Hello, World!"
------------------------------
Label : Pi
Value : 3.14159
Inspect: 3.14159
------------------------------
Label : List
Value : 1
2
3
Inspect: [1, 2, 3]
```

Extend it: accept an optional `width:` keyword argument to control the separator line length.
