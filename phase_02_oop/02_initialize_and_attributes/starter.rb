# frozen_string_literal: true

class Book
  attr_reader :title
  attr_accessor :pages

  def initialize(title, pages)
    @title = title
    @pages = pages
  end

  # TODO: return "#{title} (#{pages} pages)"
  # Hint: interpolate title and pages
  def summary
    title
  end
end

book = Book.new("Ruby Fundamentals", 300)
puts book.summary
book.pages = 350
puts book.summary
