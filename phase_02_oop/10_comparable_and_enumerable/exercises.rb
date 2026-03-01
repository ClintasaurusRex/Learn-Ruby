# frozen_string_literal: true

# Exercise 1: include Comparable and implement <=>.
class Score
  include Comparable
  attr_reader :points

  def initialize(points)
    @points = points
  end

  def <=>(other)
    # TODO: compare points values
    nil
  end
end

# Exercise 2: include Enumerable and implement each.
class WordList
  include Enumerable

  def initialize(words)
    @words = words
  end

  def each
    # TODO: support both block and enumerator usage
    return enum_for(:each) unless block_given?
  end
end

# Exercise 3: verify sorting scores.
# Exercise 4: verify map/select on words.
# Exercise 5: verify min/max and between? for comparable values.
