# Lesson 08 — ActiveRecord Associations

## 1) Concept Overview
Associations describe how models relate to each other. `belongs_to` defines the owning side, `has_many` defines collections, and `has_many :through` models many-to-many relationships with meaning.

## 2) Mental Model
```
belongs_to / has_many

Author has_many :books
Book   belongs_to :author

Author(id) 1 ---< Book(author_id)

has_many :through

Student has_many :enrollments
Course  has_many :enrollments
Student has_many :courses, through: :enrollments
Course  has_many :students, through: :enrollments

Student ---< Enrollment >--- Course
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class Author
  attr_reader :name, :books

  def initialize(name)
    @name = name
    @books = []
  end

  def add_book(book)
    # TODO: book.author = self
    # TODO: books << book
  end
end
```

## 4) You Type This
- Open `starter.rb`.
- Wire `Book#author=` and `Author#add_book`.
- Build one author with two books.
- Print association checks.

## 5) Expand the Example
Add an `Enrollment` join model between `Student` and `Course` to simulate `has_many :through` and avoid storing raw IDs in random arrays.

## 6) Real-World Application
Use `has_many :through` for roles, memberships, tags, and any relationship that needs metadata like `created_at` or `status`.

## 7) Checklist (before moving on)
- [ ] I can identify the owner in `belongs_to`.
- [ ] I can explain foreign keys.
- [ ] I can model one-to-many with `has_many`.
- [ ] I can model many-to-many with `has_many :through`.
- [ ] I can explain why join models are useful.

## 8) Common Mistakes
- Putting the foreign key on the wrong table.
- Using `has_and_belongs_to_many` when join metadata is needed.
- Forgetting to keep both sides of relationships in sync.

## 9) Debug Flow
- Missing related records? Check foreign key value.
- Duplicates? Verify append logic.
- Wrong relation shape? Draw the schema before coding.

## 10) Stretch Goal + sample output
Add enrollment roles (`student`, `assistant`) and print only assistant enrollments.

Sample output:
```
Author: Octavia Butler
Books count: 2
Student courses: Ruby 101, Rails 201
```
