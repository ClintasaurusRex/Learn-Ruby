# frozen_string_literal: true

class User
  attr_reader :name, :status

  def initialize(name, status)
    @name = name
    @status = status
  end

  def active?
    status == "active"
  end

  # TODO: implement archived?
  # Hint: compare status to "archived"
  def archived?
    false
  end
end

ava = User.new("Ava", "active")
noah = User.new("Noah", "archived")

puts "#{ava.name} active? #{ava.active?}"
puts "#{noah.name} archived? #{noah.archived?}"
