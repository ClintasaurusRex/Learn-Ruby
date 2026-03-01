# frozen_string_literal: true

class Score
  include Comparable
  attr_reader :points

  def initialize(points)
    @points = points
  end

  def <=>(other)
    points <=> other.points
  end
end

class WordList
  include Enumerable

  def initialize(words)
    @words = words
  end

  def each
    return enum_for(:each) unless block_given?

    @words.each { |word| yield word }
  end
end

puts Score.new(7) > Score.new(3)
puts [Score.new(2), Score.new(9), Score.new(4)].sort.map(&:points).inspect
words = WordList.new(%w[alpha beta gamma])
puts words.select { |w| w.length > 4 }.inspect
puts words.map(&:upcase).inspect
