# frozen_string_literal: true

def request_steps
  [
    "router matches request",
    "controller action runs",
    "model fetches or persists data",
    "view renders output",
    "response returns to client"
  ]
end

def mvc_separated?(model_has_sql:, controller_has_flow:, view_has_markup:)
  model_has_sql && controller_has_flow && view_has_markup
end

p request_steps
p mvc_separated?(model_has_sql: true, controller_has_flow: true, view_has_markup: true)
