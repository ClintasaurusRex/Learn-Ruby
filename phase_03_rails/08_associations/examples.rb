# frozen_string_literal: true

class Author
  attr_reader :name, :books

  def initialize(name)
    @name = name
    @books = []
  end

  def add_book(book)
    book.author = self
    books << book
  end
end

class Book
  attr_reader :title, :author

  def initialize(title)
    @title = title
    @author = nil
  end

  def author=(author)
    return if @author == author

    @author = author
  end
end

class Enrollment
  attr_reader :student, :course

  def initialize(student, course)
    @student = student
    @course = course
  end
end

class Student
  attr_reader :name, :enrollments

  def initialize(name)
    @name = name
    @enrollments = []
  end

  def enroll(course)
    enrollment = Enrollment.new(self, course)
    @enrollments << enrollment
    course.enrollments << enrollment
  end

  def courses
    enrollments.map(&:course)
  end
end

class Course
  attr_reader :title, :enrollments

  def initialize(title)
    @title = title
    @enrollments = []
  end

  def students
    enrollments.map(&:student)
  end
end

author = Author.new('Octavia Butler')
author.add_book(Book.new('Kindred'))
author.add_book(Book.new('Parable of the Sower'))

student = Student.new('Ari')
ruby = Course.new('Ruby 101')
rails = Course.new('Rails 201')
student.enroll(ruby)
student.enroll(rails)

puts "Author: #{author.name}"
puts "Books count: #{author.books.count}"
puts "Student courses: #{student.courses.map(&:title).join(', ')}"
