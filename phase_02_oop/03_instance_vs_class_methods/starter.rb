# frozen_string_literal: true

class Counter
  @@total_created = 0

  def self.total_created
    @@total_created
  end

  attr_reader :name

  def initialize(name)
    @name = name
    @@total_created += 1
  end

  # TODO: return "Counter<NAME>"
  # Hint: interpolate @name
  def label
    "Counter"
  end
end

counter_a = Counter.new("A")
counter_b = Counter.new("B")
puts counter_a.label
puts counter_b.label
puts "Total created: #{Counter.total_created}"
