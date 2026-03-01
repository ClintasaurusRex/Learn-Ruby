# frozen_string_literal: true

class Wallet
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def add(value)
    validate_amount(value)
    @amount += value
  end

  private

  # TODO: raise ArgumentError unless value > 0
  # Hint: raise ArgumentError, "amount must be positive"
  def validate_amount(value)
    return if value > 0

    raise ArgumentError, "amount must be positive"
  end
end

wallet = Wallet.new(20)
wallet.add(10)
puts "Balance: #{wallet.amount}"
