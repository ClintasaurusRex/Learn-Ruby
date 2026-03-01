# frozen_string_literal: true

require "rspec"

target = ENV.fetch("TARGET", "exercises")
require_relative target

RSpec.describe "Lesson 13: OOP Refactor Challenge" do
  let(:items) do
    [
      CartItem.new(name: "Book", price: 12.0, qty: 2),
      CartItem.new(name: "Pen", price: 2.0, qty: 3)
    ]
  end

  it "cart item computes line_total" do
    expect(items.first.line_total).to eq(24.0)
  end

  it "cart computes subtotal" do
    expect(Cart.new(items).subtotal).to eq(30.0)
  end

  it "checkout computes tax" do
    expect(CheckoutService.new(Cart.new(items)).tax).to eq(3.0)
  end

  it "checkout computes total" do
    expect(CheckoutService.new(Cart.new(items)).total).to eq(33.0)
  end

  it "receipt renders before/after compatible values" do
    cart = Cart.new(items)
    checkout = CheckoutService.new(cart)
    receipt = Receipt.new(cart: cart, checkout: checkout)

    expect(receipt.render).to eq("subtotal: 30.0\ntax: 3.0\ntotal: 33.0")
  end
end
