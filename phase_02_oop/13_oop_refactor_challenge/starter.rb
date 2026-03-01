# frozen_string_literal: true

# Procedural starting point
items = [
  { name: "Book", price: 12.0, qty: 2 },
  { name: "Pen", price: 2.0, qty: 3 }
]

subtotal = items.sum { |item| item[:price] * item[:qty] }
tax = subtotal * 0.1
total = subtotal + tax

# TODO: extract CartItem class
# Hint: each item should know its own line_total

# TODO: extract Cart class
# Hint: cart computes subtotal

# TODO: extract CheckoutService class
# Hint: service computes tax and total

puts "subtotal: #{subtotal}"
puts "tax: #{tax}"
puts "total: #{total}"
