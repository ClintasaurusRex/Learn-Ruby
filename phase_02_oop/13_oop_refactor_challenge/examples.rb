# frozen_string_literal: true

# BEFORE: bad procedural script
items = [
  { name: "Book", price: 12.0, qty: 2 },
  { name: "Pen", price: 2.0, qty: 3 }
]

subtotal_before = items.sum { |item| item[:price] * item[:qty] }
tax_before = subtotal_before * 0.1
total_before = subtotal_before + tax_before
puts "BEFORE subtotal: #{subtotal_before}"
puts "BEFORE tax: #{tax_before}"
puts "BEFORE total: #{total_before}"

# STEP 1: extract CartItem
class CartItem
  attr_reader :name, :price, :qty

  def initialize(name:, price:, qty:)
    @name = name
    @price = price
    @qty = qty
  end

  def line_total
    price * qty
  end
end

# STEP 2: extract Cart
class Cart
  def initialize(items)
    @items = items
  end

  def subtotal
    @items.sum(&:line_total)
  end
end

# STEP 3: extract CheckoutService
class CheckoutService
  def initialize(cart, tax_rate: 0.1)
    @cart = cart
    @tax_rate = tax_rate
  end

  def tax
    @cart.subtotal * @tax_rate
  end

  def total
    @cart.subtotal + tax
  end
end

items_after = [
  CartItem.new(name: "Book", price: 12.0, qty: 2),
  CartItem.new(name: "Pen", price: 2.0, qty: 3)
]
cart = Cart.new(items_after)
checkout = CheckoutService.new(cart)
puts "AFTER subtotal: #{cart.subtotal}"
puts "AFTER tax: #{checkout.tax}"
puts "AFTER total: #{checkout.total}"
