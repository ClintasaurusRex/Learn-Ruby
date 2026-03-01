# frozen_string_literal: true

puts "Lesson 00: Rails Overview"

request = { verb: "GET", path: "/posts/1" }
route = "posts#show"
controller_action = "PostsController#show"
model_call = "Post.find(1)"
view = "app/views/posts/show.html.erb"

puts "Request: #{request[:verb]} #{request[:path]}"
puts "Route matched: #{route}"
puts "Controller action: #{controller_action}"
puts "Model call: #{model_call}"
puts "Rendered view: #{view}"
puts "Response: 200 OK (HTML)"
