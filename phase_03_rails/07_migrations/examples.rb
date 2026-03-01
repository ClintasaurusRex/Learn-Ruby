# frozen_string_literal: true

puts "Lesson 07: Migrations"

timeline = [
  "20260301010000_create_users.rb",
  "20260301011000_add_role_to_users.rb",
  "20260301012000_create_posts.rb"
]

timeline.each_with_index do |migration, index|
  puts "#{index + 1}. #{migration}"
end

puts "Applied in order: earliest timestamp first."
