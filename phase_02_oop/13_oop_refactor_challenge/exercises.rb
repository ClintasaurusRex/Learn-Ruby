# frozen_string_literal: true

# Refactor Step 1:
# Create CartItem with name, price, qty and #line_total.
class CartItem
  attr_reader :name, :price, :qty

  def initialize(name:, price:, qty:)
    @name = name
    @price = price
    @qty = qty
  end

  def line_total
    # TODO: multiply price by qty
    0
  end
end

# Refactor Step 2:
# Create Cart that owns many items and computes subtotal.
class Cart
  def initialize(items)
    @items = items
  end

  def subtotal
    # TODO: sum each item's line_total
    0
  end
end

# Refactor Step 3:
# Create CheckoutService for tax + total logic.
class CheckoutService
  def initialize(cart, tax_rate: 0.1)
    @cart = cart
    @tax_rate = tax_rate
  end

  def tax
    # TODO: subtotal * tax_rate
    0
  end

  def total
    # TODO: subtotal + tax
    0
  end
end

# Refactor Step 4:
# Keep output formatting separate.
class Receipt
  def initialize(cart:, checkout:)
    @cart = cart
    @checkout = checkout
  end

  def render
    # TODO: return a 3-line receipt string
    "TODO"
  end
end

# Refactor Step 5:
# Ensure behavior matches procedural script totals.
