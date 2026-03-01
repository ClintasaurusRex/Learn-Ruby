# frozen_string_literal: true

puts "Lesson 01: New App and Structure"

folders = {
  "app/controllers" => "request handling",
  "app/models" => "data and business logic",
  "app/views" => "template rendering",
  "config/routes.rb" => "URL mapping",
  "db/migrate" => "schema changes"
}

folders.each do |path, purpose|
  puts "#{path.ljust(20)} -> #{purpose}"
end
