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

module UppercaseTitle
  def title
    super.upcase
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

class LoudArticle < Article
  prepend UppercaseTitle
end

article = Article.new("Mixin Layering", "Nina")
puts article.slug
puts Article.label
puts LoudArticle.new("Mixin Layering", "Nina").title
puts LoudArticle.ancestors.inspect
