# frozen_string_literal: true

puts "Lesson 04: Controllers"

def create_action(valid)
  if valid
    :redirect
  else
    :render
  end
end

puts "create(valid=true)  => #{create_action(true)}"
puts "create(valid=false) => #{create_action(false)}"
