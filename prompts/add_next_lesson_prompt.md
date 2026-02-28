# Prompt: Add Next Lesson

You are extending the **Learn-Ruby** repository. Before writing a single line,
check the existing structure so your new lesson matches perfectly.

---

## Step 1 — Audit the existing structure

1. List every folder inside `phase_01_ruby_core/` (or whichever phase applies).
2. Note the highest lesson number so yours comes next in sequence.
3. Open at least two existing lesson READMEs and compare their 10-section format.
4. Read an existing `starter.rb`, `exercises.rb`, `solutions.rb`, and
   `test_lesson.rb` so you can match the style exactly.
5. Read `ROADMAP.md` and `docs/TABLE_OF_CONTENTS.md` so you know what to update.

---

## Step 2 — Plan the lesson

State clearly:
- Lesson number and folder name (e.g. `10_enumerables`)
- The concept being taught
- The 4–6 exercises you will include
- The RSpec tests you will write (these must **fail** on unmodified starter code)

---

## Step 3 — Create the lesson folder and all 6 files

Create the folder, then create **every one** of these files. No placeholders —
every file must contain real, working, complete content.

### `README.md`

Follow the exact 10-section format used by existing lessons:

1. **Concept Overview** — plain-English explanation (3–6 sentences)
2. **Mental Model Diagram** — ASCII diagram showing the concept visually
3. **Starter Code** — runnable Ruby snippet illustrating the concept
4. **You Type This** — numbered list of exercises the student completes
5. **Expand the Example** — deeper examples and edge cases with code blocks
6. **Real-World Application** — how this is used on the job, with a realistic code sample
7. **Checklist** — `- [ ]` checkboxes the student ticks off before moving on
8. **Common Mistakes** — markdown table: Mistake | Fix
9. **Debug Flow** — indented ASCII tree of "what to check when things go wrong"
10. **Stretch Goal** — one harder challenge that extends the lesson concept

### `starter.rb`

- Frozen string literal comment at the top
- Header comment block with lesson name, file purpose, and run instructions
- Working demo code that illustrates the concept (student can run immediately)
- `# TODO:` comments marking exactly what the student must implement
- `# Hint:` comments below each TODO giving a concrete nudge
- Expected output shown as inline comments (e.g. `# => 42`)
- No unimplemented stubs that would raise errors on run — the non-TODO parts must work

### `examples.rb`

- Frozen string literal comment at the top
- Header comment block
- Fully working, self-contained examples that demonstrate every aspect of the concept
- Run with `ruby examples.rb` — must produce clean output with zero errors
- Verify this file runs cleanly before committing

### `exercises.rb`

- Frozen string literal comment at the top
- Header comment block
- Method stubs (or class stubs) for each exercise — bodies intentionally empty or returning `nil`
- Each stub has a `# TODO:` comment and one or more `# Hint:` comments
- The stubs must match the method signatures tested in `test_lesson.rb` exactly

### `solutions.rb`

- Frozen string literal comment at the top
- Header comment block
- Complete, correct implementations of every exercise from `exercises.rb`
- Inline comments explaining each non-obvious step
- Must pass all RSpec tests when substituted for `exercises.rb`

### `test_lesson.rb`

- Frozen string literal comment at the top
- Header comment with run instructions (`bundle exec rspec test_lesson.rb --format documentation`)
- `require "rspec"` and `require_relative "exercises"`
- One `RSpec.describe` block per exercise
- Each describe block has at minimum:
  - A happy-path test
  - An edge-case test
  - A test that will **fail** on the unmodified empty stub
- Tests must be self-contained (no external fixtures)

---

## Step 4 — Update ROADMAP.md

Find the correct position in the checkbox list and add:

```
- [ ] Lesson XX — <Lesson Title>
```

---

## Step 5 — Update docs/TABLE_OF_CONTENTS.md

Add a markdown link to the new lesson in the correct numbered position:

```
- [Lesson XX — <Lesson Title>](../phase_01_ruby_core/XX_<folder_name>/README.md)
```

---

## Step 6 — Verify before committing

- [ ] `ruby examples.rb` runs with no errors
- [ ] `ruby starter.rb` runs with no errors (the non-TODO parts)
- [ ] `bundle exec rspec test_lesson.rb` shows failing tests (expected — stubs are empty)
- [ ] All 6 files exist in the new lesson folder
- [ ] ROADMAP.md and TABLE_OF_CONTENTS.md are updated
- [ ] No placeholder text ("TODO: fill this in later") anywhere

---

## Constraints

- **No placeholders.** Every file must contain real, complete content.
- Match the style of existing lessons exactly — same comment style, same heading levels,
  same ASCII diagram style.
- Tests must fail on the unmodified `exercises.rb` stubs and pass when `solutions.rb`
  content is used.
