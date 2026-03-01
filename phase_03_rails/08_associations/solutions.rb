# frozen_string_literal: true

# Exercise 1 solution
def belongs_to_example
  'Book belongs_to Author'
end

# Exercise 2 solution
def valid_foreign_key?(book_row)
  book_row.key?(:author_id)
end

# Exercise 3 solution
def course_titles_from_enrollments(enrollments)
  enrollments.map { |enrollment| enrollment[:course][:title] }
end

# Exercise 4 solution
def association_triangle
  ['belongs_to', 'has_many', 'has_many :through']
end

# Exercise 5 solution
def relation_summary(author_name, count)
  "Author #{author_name} has #{count} books"
end

puts belongs_to_example
puts valid_foreign_key?(author_id: 2)
p course_titles_from_enrollments([{ course: { title: 'Rails 201' } }])
p association_triangle
puts relation_summary('Octavia Butler', 2)
