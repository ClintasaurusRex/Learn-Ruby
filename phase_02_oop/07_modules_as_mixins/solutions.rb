# frozen_string_literal: true

module Slugifiable
  def slug
    title.downcase.gsub(/\s+/, "-")
  end
end

module ClassLabel
  def label
    name
  end
end

class Article
  include Slugifiable
  extend ClassLabel

  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end
end

module UppercaseTitle
  def title
    super.upcase
  end
end

class LoudArticle < Article
  prepend UppercaseTitle
end

puts "Exercise 1: slug turns title into URL-safe format"
puts Article.new("Ruby Mixins", "Ada").slug
puts "Exercise 2: extend gives class methods"
puts Article.label
puts "Exercise 3: prepend wraps inherited title"
puts LoudArticle.new("Ruby Mixins", "Ada").title
