# frozen_string_literal: true

def classify_layer(example)
  text = example.downcase
  return :model if text.include?("validates") || text.include?("scope") || text.include?("where(")
  return :controller if text.include?("redirect_to") || text.include?("render") || text.include?("params")

  :view
end

def good_boundary?(model_logic:, controller_flow:, view_markup:)
  model_logic && controller_flow && view_markup
end

p classify_layer("validates :name, presence: true")
p good_boundary?(model_logic: true, controller_flow: true, view_markup: true)
