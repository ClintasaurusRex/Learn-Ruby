# frozen_string_literal: true

class Order
  attr_reader :total_cents

  def initialize(total_cents)
    @total_cents = total_cents
  end

  def checkout
    # TODO: delegate to service object
    "Charged order total: #{total_cents}"
  end
end

order = Order.new(2599)
puts order.checkout
