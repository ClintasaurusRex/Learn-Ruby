# frozen_string_literal: true

puts "Lesson 05: Views and ERB"

post = { title: "Hello Rails", body: "Templates with ERB" }

puts "<h1>#{post[:title]}</h1>"
puts "<p>#{post[:body]}</p>"
puts "Rendered with simulated ERB interpolation."
