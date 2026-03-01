# frozen_string_literal: true

require "rspec"

target = ENV.fetch("TARGET", "exercises")
require_relative target

RSpec.describe "Lesson 12: OOP Design Principles" do
  it "order keeps subtotal responsibility" do
    expect(Order.new([3, 4, 5]).subtotal).to eq(12)
  end

  it "tax policy can be applied without editing checkout" do
    expect(USTaxPolicy.new.apply(10)).to eq(11.0)
  end

  it "gateway follows shared charge contract" do
    expect(Gateway.new.charge(11.0)).to eq("charged 11.0")
  end

  it "printer only formats receipt output" do
    expect(ReceiptPrinter.new.print(11.0)).to eq("receipt total: 11.0")
  end

  it "checkout composes dependencies" do
    checkout = Checkout.new(tax_policy: USTaxPolicy.new, gateway: Gateway.new, printer: ReceiptPrinter.new)
    expect(checkout.finalize(Order.new([5, 5]))).to eq(["charged 11.0", "receipt total: 11.0"])
  end
end
