# frozen_string_literal: true

class Counter
  @@total_created = 0

  def self.total_created
    @@total_created
  end

  def self.reset_total!
    @@total_created = 0
  end

  attr_reader :name

  def initialize(name)
    @name = name
    @@total_created += 1
  end

  def label
    "Counter<#{name}>"
  end
end

Counter.reset_total!
a = Counter.new("A")
b = Counter.new("B")
puts a.label
puts b.label
puts "Total created: #{Counter.total_created}"
