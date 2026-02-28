# Prompt: Expand Documentation

You are expanding an existing documentation file in this repository. Before
making any changes, read the file carefully so your additions blend in perfectly.

---

## Step 1 — Identify the target file

The file to expand is:

> **[Agent: fill in the specific doc file path here before running this prompt]**
> Example: `docs/TABLE_OF_CONTENTS.md` or `phase_01_ruby_core/05_methods_and_procs/README.md`

---

## Step 2 — Audit the existing file

1. Read the entire file from top to bottom.
2. Note the heading levels, section order, and overall structure.
3. Note the writing style — tone, sentence length, level of technicality.
4. Note existing ASCII diagrams (style, width, characters used).
5. Note existing code examples (language, comment style, expected-output format).
6. Identify which of the following sections are **missing** and need to be added:
   - Troubleshooting section
   - Common mistakes section
7. Identify where more ASCII diagrams would help understanding.
8. Identify where more copy/paste code examples would be useful.

---

## Step 3 — Add more ASCII diagrams

For each concept in the file that could be shown visually:

- Draw an ASCII diagram that matches the style already present in the file
  (same box characters, same indentation, same width conventions)
- Place the diagram directly below the relevant prose or heading
- Add a short caption line above the diagram explaining what it shows

Example style to match (adapt to whatever style is in the target file):

```
CONCEPT NAME
────────────────────────────────
    ┌─────────┐
    │  Input  │
    └────┬────┘
         │ transform
    ┌────▼────┐
    │ Output  │
    └─────────┘
```

---

## Step 4 — Add more copy/paste code examples

For each concept or sub-concept that lacks a concrete code example:

- Write a complete, runnable code snippet
- Use the same language and formatting as existing examples in the file
- Show expected output as inline comments (e.g. `# => "result"`) or in a
  separate output block, matching the existing style
- Keep examples short enough to copy and run immediately (no external
  dependencies unless the file already uses them)

---

## Step 5 — Add a Troubleshooting section (if missing)

If the file does not already have a troubleshooting section, add one using
this format (adapted to the file's heading style):

```
## Troubleshooting

**Problem:** <describe the problem>
**Cause:** <explain why it happens>
**Fix:** <concrete steps or code to resolve it>

---

**Problem:** <describe the next problem>
...
```

Include at least three real, common problems related to the topic of the file.

---

## Step 6 — Add a Common Mistakes section (if missing)

If the file does not already have a common mistakes section, add one using
this format (adapted to the file's heading style):

```
## Common Mistakes

| Mistake | Why It Happens | Fix |
|---------|----------------|-----|
| <mistake> | <cause> | <fix> |
```

Include at least four rows covering real mistakes beginners make with this topic.

---

## Step 7 — Verify before committing

- [ ] The new content matches the existing heading levels exactly
- [ ] All ASCII diagrams use the same characters and width as existing diagrams
- [ ] All new code examples run without errors
- [ ] The troubleshooting section is present (added or already existed)
- [ ] The common mistakes section is present (added or already existed)
- [ ] No placeholder text anywhere in the file
- [ ] The overall style and tone are consistent throughout the file

---

## Constraints

- **No placeholders.** All added content must be real and complete.
- Do not alter any existing content — only add new content.
- Maintain the exact same style, tone, heading levels, and formatting as the
  existing file.
- Code examples must be correct and runnable.
