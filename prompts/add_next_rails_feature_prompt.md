# Prompt: Add Next Rails Feature

You are extending an existing Rails project inside this repository. Before
writing any code, audit the project so your new feature fits in seamlessly.

---

## Step 1 — Audit the existing project structure

1. List every file and folder in the Rails project root.
2. Read `config/routes.rb` — note the routing conventions already in use.
3. Read at least two existing controllers to understand naming, before actions,
   strong params patterns, and response formats.
4. Read at least two existing models to understand validations, associations,
   and scopes.
5. Read at least two existing view templates to understand the layout,
   partials, and helper usage.
6. Read the existing RSpec files (`spec/`) to understand test structure,
   factory usage, and shared examples.
7. Read the project README to understand how features are documented.

---

## Step 2 — Plan the feature

State clearly:
- Feature name and a one-sentence description
- Resource(s) involved (model names, table names)
- Routes to add (HTTP verb, path, controller#action)
- Controller actions needed
- Model changes needed (new columns, associations, validations, scopes)
- Views needed
- RSpec tests to write (request specs, model specs, view/system specs as needed)
- Every design decision, explained in plain language (why this approach, not another)

---

## Step 3 — Implement the feature

### Model

- Generate or edit the model file
- Add validations with plain-language inline comments explaining each rule
- Add associations with comments explaining the relationship
- Add scopes where useful, with comments explaining when to use each
- Write a migration if new columns or tables are needed

### Controller

- Follow the same naming and structural conventions as existing controllers
- Use strong params — explain which attributes are permitted and why
- Add before actions for authentication/authorization if the pattern is already in use
- Handle both success and failure paths explicitly
- Add comments explaining each non-obvious decision

### Routes

- Add routes in the same style as existing routes (resources, namespace, etc.)
- Comment each new route group explaining what it enables

### Views

- Match the existing layout and partial conventions
- Use the same helper methods already available in the project
- Add comments in the template explaining any non-obvious logic

---

## Step 4 — Write RSpec tests

Write tests that cover:

- **Model spec**: validations (valid and invalid cases), associations, scopes
- **Request spec** (or controller spec): each action's happy path and failure path,
  authentication/authorization if applicable
- **System or view spec** (if the project already has them): key user flows

Each test must:
- Be self-contained
- Use factories or fixtures in the same style as existing tests
- Include a comment explaining what it is verifying and why

---

## Step 5 — Update the project README

Add a section for the new feature that includes:

- Feature name and purpose
- Setup steps (migrations, seed data if any)
- API or UI usage examples
- Any environment variables or configuration required

---

## Step 6 — Verify before committing

- [ ] `rails db:migrate` runs without errors
- [ ] `bundle exec rspec spec/` passes all tests (new and existing)
- [ ] The feature works end-to-end in `rails server` (confirm manually)
- [ ] No placeholder text anywhere
- [ ] README updated

---

## Constraints

- **No placeholders.** All code must be real and complete.
- Match existing code conventions exactly — naming, indentation, comment style.
- Explain every design decision in plain language inside the code as comments
  or in the README.
- Do not modify existing tests unless fixing a genuine conflict caused by
  your migration or model change, and explain any such change.
