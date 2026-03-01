# frozen_string_literal: true

puts "Lesson 02: MVC Deep Dive"

snippets = {
  "validates :email, presence: true" => :model,
  "redirect_to dashboard_path" => :controller,
  "<%= @user.name %>" => :view
}

snippets.each do |code, layer|
  puts "#{code.inspect} belongs to #{layer}"
end
