# frozen_string_literal: true

module Notifiable
  def notify(message)
    "Notify: #{message}"
  end
end

class ChargeOrder
  def initialize(order)
    @order = order
  end

  def call
    "Charged order total: #{@order.total_cents}"
  end
end

class Order
  include Notifiable

  attr_reader :total_cents

  def initialize(total_cents)
    @total_cents = total_cents
  end

  def checkout
    ChargeOrder.new(self).call
  end
end

class OrderDecorator
  def initialize(order)
    @order = order
  end

  def formatted_total
    dollars = @order.total_cents / 100.0
    format('$%.2f', dollars)
  end
end

def choose_pattern(need)
  case need
  when :orchestration
    :service_object
  when :shared_model_behavior
    :concern
  when :presentation_formatting
    :decorator
  else
    :inline
  end
end

order = Order.new(2599)
puts order.checkout
puts "Formatted total: #{OrderDecorator.new(order).formatted_total}"
puts "Decision for :orchestration => #{choose_pattern(:orchestration)}"
