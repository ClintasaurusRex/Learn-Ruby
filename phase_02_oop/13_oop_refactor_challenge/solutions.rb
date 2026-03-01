# frozen_string_literal: true

# BEFORE (procedural reference)
raw_items = [
  { name: "Book", price: 12.0, qty: 2 },
  { name: "Pen", price: 2.0, qty: 3 }
]
subtotal_before = raw_items.sum { |item| item[:price] * item[:qty] }
tax_before = subtotal_before * 0.1
total_before = subtotal_before + tax_before

# AFTER (OOP refactor)
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

class Cart
  def initialize(items)
    @items = items
  end

  def subtotal
    @items.sum(&:line_total)
  end
end

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

class Receipt
  def initialize(cart:, checkout:)
    @cart = cart
    @checkout = checkout
  end

  def render
    [
      "subtotal: #{@cart.subtotal}",
      "tax: #{@checkout.tax}",
      "total: #{@checkout.total}"
    ].join("\n")
  end
end

items = [
  CartItem.new(name: "Book", price: 12.0, qty: 2),
  CartItem.new(name: "Pen", price: 2.0, qty: 3)
]
cart = Cart.new(items)
checkout = CheckoutService.new(cart)
receipt = Receipt.new(cart: cart, checkout: checkout)

puts "BEFORE subtotal: #{subtotal_before}"
puts "BEFORE tax: #{tax_before}"
puts "BEFORE total: #{total_before}"
puts "AFTER"
puts receipt.render
