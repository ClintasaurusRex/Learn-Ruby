# frozen_string_literal: true

class Author
  attr_reader :name, :books

  def initialize(name)
    @name = name
    @books = []
  end

  def add_book(book)
    # TODO: set the book's author
    # TODO: append book to books
  end
end

class Book
  attr_reader :title, :author

  def initialize(title)
    @title = title
    @author = nil
  end

  def author=(author)
    @author = author
  end
end

author = Author.new('Octavia Butler')
book = Book.new('Parable of the Sower')
author.add_book(book)

puts "Book author set? #{book.author&.name == 'Octavia Butler'}"
puts "Author books count: #{author.books.length}"
