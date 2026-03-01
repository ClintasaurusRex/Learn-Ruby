# frozen_string_literal: true

puts "Lesson 06: Models and Active Record"

crud = {
  create: "INSERT",
  read: "SELECT",
  update: "UPDATE",
  delete: "DELETE"
}

crud.each do |action, sql|
  puts "#{action.to_s.capitalize.ljust(6)} -> #{sql}"
end
