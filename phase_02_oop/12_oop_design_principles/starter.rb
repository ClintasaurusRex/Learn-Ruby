# frozen_string_literal: true

class Order
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def subtotal
    items.sum
  end
end

class USTaxPolicy
  def apply(amount)
    amount * 1.1
  end
end

class ReceiptPrinter
  def print(total)
    "receipt total: #{total.round(2)}"
  end
end

class Gateway
  def charge(amount)
    "charged #{amount.round(2)}"
  end
end

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

checkout = Checkout.new(tax_policy: USTaxPolicy.new, gateway: Gateway.new, printer: ReceiptPrinter.new)
puts checkout.finalize(Order.new([5, 5]))
