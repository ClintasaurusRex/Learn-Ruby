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

  def richer_than?(other)
    higher_or_equal_balance?(other)
  end

  protected

  def higher_or_equal_balance?(other)
    amount >= other.amount
  end

  private

  def validate_amount(value)
    return if value > 0

    raise ArgumentError, "amount must be positive"
  end
end

wallet_a = Wallet.new(20)
wallet_b = Wallet.new(15)
wallet_a.add(10)
puts "Balance A: #{wallet_a.amount}"
puts "A richer than B? #{wallet_a.richer_than?(wallet_b)}"
