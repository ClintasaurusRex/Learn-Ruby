# frozen_string_literal: true

# Exercise 1: Complete #slug
# Hint: downcase and replace spaces with dashes.
module Slugifiable
  def slug
    # TODO: implement slug formatting
    nil
  end
end

# Exercise 2: Add class-level label behavior.
# Hint: this module will be used with extend.
module ClassLabel
  def label
    # TODO: return class name
    nil
  end
end

# Exercise 3: wire include + extend.
class Article
  include Slugifiable
  extend ClassLabel

  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end
end

# Exercise 4: use prepend to transform title.
# Hint: call super, then upcase.
module UppercaseTitle
  def title
    super
  end
end

# Exercise 5: verify method layering by using LoudArticle.
class LoudArticle < Article
  prepend UppercaseTitle
end
