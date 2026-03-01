# frozen_string_literal: true

# Exercise 1 (S): keep order math in Order.
class Order
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def subtotal
    items.sum
  end
end

# Exercise 2 (O): make policies swappable.
class USTaxPolicy
  def apply(amount)
    # TODO: apply 10% tax
    amount
  end
end

# Exercise 3 (I): keep printer focused only on printing.
class ReceiptPrinter
  def print(total)
    "TODO"
  end
end

# Exercise 4 (L): gateways should share charge contract.
class Gateway
  def charge(amount)
    "TODO"
  end
end

# Exercise 5 (D): checkout should depend on injected abstractions.
class Checkout
  def initialize(tax_policy:, gateway:, printer:)
    @tax_policy = tax_policy
    @gateway = gateway
    @printer = printer
  end

  def finalize(order)
    total = @tax_policy.apply(order.subtotal)
    [@gateway.charge(total), @printer.print(total)]
  end
end
