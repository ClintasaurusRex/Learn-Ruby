# frozen_string_literal: true

puts "Lesson 03: Routing"

routes = [
  ["GET", "/posts", "posts#index"],
  ["GET", "/posts/1", "posts#show"],
  ["POST", "/posts", "posts#create"]
]

routes.each do |verb, path, action|
  puts "#{verb.ljust(6)} #{path.ljust(12)} -> #{action}"
end
