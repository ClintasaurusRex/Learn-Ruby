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

  def archived?
    status == "archived"
  end

  def status_label
    "#{name}: #{status}"
  end
end

users = [
  User.new("Ava", "active"),
  User.new("Noah", "archived")
]

users.each do |user|
  puts user.status_label
  puts "  active? #{user.active?}"
  puts "  archived? #{user.archived?}"
end
