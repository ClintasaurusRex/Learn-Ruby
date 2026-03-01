# frozen_string_literal: true

class Book
  attr_reader :title, :author
  attr_accessor :pages

  def initialize(title, author, pages)
    @title = title
    @author = author
    @pages = pages
  end

  def summary
    "#{title} by #{author} (#{pages} pages)"
  end
end

book = Book.new("Ruby Fundamentals", "A. Dev", 300)
puts book.summary
book.pages = 350
puts book.summary
puts "title reader -> #{book.title}"
puts "author reader -> #{book.author}"
