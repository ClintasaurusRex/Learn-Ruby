# frozen_string_literal: true

def erb_echo(value)
  value.to_s
end

def render_state(items)
  items.empty? ? "empty" : "list"
end

p erb_echo(123)
p render_state([])
p render_state([:a])
