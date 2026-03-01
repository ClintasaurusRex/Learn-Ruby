# frozen_string_literal: true

# Exercise 1: return true when a model belongs_to another model.
def belongs_to_example
  # TODO: return a sentence containing "Book belongs_to Author"
end

# Exercise 2: return true if foreign key placement is correct.
def valid_foreign_key?(book_row)
  # TODO: foreign key should live on Book as :author_id
end

# Exercise 3: map enrollments to courses (has_many :through mental model).
def course_titles_from_enrollments(enrollments)
  # TODO: return array of course titles
end

# Exercise 4: return the association triangle labels.
def association_triangle
  # TODO: ["belongs_to", "has_many", "has_many :through"]
end

# Exercise 5: build readable relation summary.
def relation_summary(author_name, count)
  # TODO: "Author <name> has <count> books"
end
