# frozen_string_literal: true

module Slugifiable
  def slug
    title.downcase.gsub(/\s+/, "-")
  end
end

module ClassLabel
  # TODO: return the class name as a string
  # Hint: use self.name
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
  # TODO: wrap title with uppercase transformation
  # Hint: call super, then upcase
  def title
    super
  end
end

class LoudArticle < Article
  prepend UppercaseTitle
end

sample = Article.new("Ruby Mixins", "Ada")
puts sample.slug
puts Article.label
puts LoudArticle.new("Ruby Mixins", "Ada").title
