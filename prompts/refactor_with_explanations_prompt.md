# Prompt: Refactor with Explanations

You are refactoring an existing Ruby file in this repository for clarity and
adherence to Ruby best practices. Before changing anything, read the file
thoroughly so your refactoring is informed and targeted.

---

## Step 1 — Identify the target file

The file to refactor is:

> **[Agent: fill in the specific file path here before running this prompt]**
> Example: `phase_01_ruby_core/05_methods_and_procs/examples.rb`

---

## Step 2 — Audit the existing file

1. Read the entire file from top to bottom.
2. Note what the file does — its purpose, the methods or classes it defines,
   and the output it produces.
3. Run the file if it is executable (`ruby <file>`) and confirm the current
   output.
4. Run the existing tests for this file (if any) and record which pass and
   which fail before you touch anything.
5. List every issue you find: unclear naming, missing frozen string literal,
   long methods, unclear logic, missing error handling, missing type hints
   or docstrings, style inconsistencies.

---

## Step 3 — Refactor for clarity and Ruby best practices

Apply the following improvements where relevant. For **every change**, write a
plain-language explanation directly above the changed code as a comment block,
using this format:

```ruby
# CHANGE: <one-line summary of what changed>
# WHY:    <plain-language reason — what was wrong and why this is better>
```

Improvements to apply:

- Add `# frozen_string_literal: true` if missing
- Rename variables and methods to be self-documenting (no single-letter names
  outside of short blocks, no abbreviations that obscure meaning)
- Break long methods into smaller, single-purpose methods
- Replace imperative loops with idiomatic Ruby enumerables
  (`map`, `select`, `reduce`, `each_with_object`, etc.) where they improve clarity
- Replace `if/else` chains with guard clauses where appropriate
- Add method-level documentation comments (`# @param`, `# @return`) where the
  method signature alone does not make intent obvious
- Remove redundant code and dead code
- Make implicit return values explicit where it aids readability
- Ensure consistent indentation and spacing (2-space indent, spaces around
  operators)

---

## Step 4 — Show a before/after comparison for significant changes

For any change that meaningfully alters logic or structure (not just style),
show a before/after block:

```ruby
# BEFORE:
# def x(a)
#   ...old code...
# end

# AFTER:
def x(a)
  # ...new code...
end
```

Place the before block as a comment immediately above the new code so the
comparison is visible in context.

---

## Step 5 — Maintain or improve test coverage

1. Run the existing tests after refactoring and confirm they all still pass.
2. If any test now fails because of a renamed method or changed return value,
   update the test — and explain the update with a `# CHANGE:` / `# WHY:`
   comment in the test file.
3. If the original file had no tests, add a `test_<filename>.rb` using RSpec
   that covers:
   - Each public method's happy path
   - At least one edge case per method
   - At least one failure case per method (invalid input, nil, empty)

---

## Step 6 — Add type hints and docstrings where missing

For each public method that lacks documentation, add:

```ruby
# Brief description of what the method does.
#
# @param param_name [Type] Description of the parameter
# @return [Type] Description of the return value
# @raise [ErrorClass] When this error is raised (if applicable)
def method_name(param_name)
  ...
end
```

Use `[String]`, `[Integer]`, `[Array<String>]`, `[Hash]`, `[Boolean]`,
`[nil]`, or compound types as appropriate.

---

## Step 7 — Verify before committing

- [ ] `ruby <file>` produces the same output as before the refactor
- [ ] All existing tests pass
- [ ] Every change has a `# CHANGE:` / `# WHY:` comment above it
- [ ] Before/after comparisons are included for significant logic changes
- [ ] Type hints and docstrings are added to all public methods
- [ ] No placeholder text anywhere
- [ ] `# frozen_string_literal: true` is present at the top of the file

---

## Constraints

- **No placeholders.** All changes must be real and complete.
- Do not change observable behavior — the file must produce the same results
  after refactoring.
- Explain every change in plain language. Another developer reading the file
  for the first time should understand what changed and why.
- Do not remove or weaken existing tests. Add tests; never delete them.
