# frozen_string_literal: true

class Score
  include Comparable
  attr_reader :points

  def initialize(points)
    @points = points
  end

  def <=>(other)
    # TODO: compare points
    # Hint: use Integer#<=>
    points <=> other.points
  end
end

class WordList
  include Enumerable

  def initialize(words)
    @words = words
  end

  def each
    # TODO: yield each word and return enumerator when no block
    return enum_for(:each) unless block_given?

    @words.each { |word| yield word }
  end
end

puts Score.new(5) > Score.new(3)
puts WordList.new(%w[alpha beta]).map(&:upcase).inspect
