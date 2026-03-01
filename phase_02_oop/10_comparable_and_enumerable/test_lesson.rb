# frozen_string_literal: true

require "rspec"

target = ENV.fetch("TARGET", "exercises")
require_relative target

RSpec.describe "Lesson 10: Comparable and Enumerable" do
  it "supports comparable greater-than" do
    expect(Score.new(10) > Score.new(3)).to be(true)
  end

  it "sorts score objects by points" do
    sorted = [Score.new(7), Score.new(2), Score.new(5)].sort.map(&:points)
    expect(sorted).to eq([2, 5, 7])
  end

  it "supports between? from comparable" do
    middle = Score.new(5)
    expect(middle.between?(Score.new(1), Score.new(9))).to be(true)
  end

  it "maps words through enumerable" do
    words = WordList.new(%w[alpha beta])
    expect(words.map(&:upcase)).to eq(%w[ALPHA BETA])
  end

  it "selects words through enumerable" do
    words = WordList.new(%w[alpha beta gamma])
    expect(words.select { |word| word.length > 4 }).to eq(%w[alpha gamma])
  end
end
