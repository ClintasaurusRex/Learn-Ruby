# frozen_string_literal: true

require "rspec"
require_relative ENV.fetch("LESSON_FILE", "exercises")

RenderableStub = Struct.new(:value) do
  def render
    value
  end
end

RSpec.describe "Lesson 06: Polymorphism" do
  it "returns polymorphism phrase" do
    expect(polymorphism_phrase).to eq("same message, different behavior")
  end

  it "checks renderability" do
    expect(renderable?(RenderableStub.new("ok"))).to be(true)
    expect(renderable?(Object.new)).to be(false)
  end

  it "returns text render string" do
    expect(text_render).to eq("TEXT: hello")
  end

  it "returns email render string" do
    expect(email_render).to eq("EMAIL: hello")
  end

  it "collects render outputs" do
    list = [RenderableStub.new("one"), RenderableStub.new("two")]
    expect(collect_renders(list)).to eq(["one", "two"])
  end
end
