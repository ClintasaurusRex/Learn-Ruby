# frozen_string_literal: true

# Exercise 1 solution
def valid_order_total?(subtotal, tax)
  (subtotal + tax).positive?
end

# Exercise 2 solution
def request_contract_ok?(status, body)
  status == 200 && body.key?(:data)
end

# Exercise 3 solution
def system_scenarios
  ['user signs in and sees dashboard', 'user creates order and sees confirmation']
end

# Exercise 4 solution
def test_pyramid_layers
  ['model', 'request', 'system']
end

# Exercise 5 solution
def preferred_test_level(change_type)
  case change_type
  when :pure_logic
    :model
  when :endpoint_contract
    :request
  else
    :system
  end
end

p valid_order_total?(10, 1)
p request_contract_ok?(200, data: { id: 1 })
p system_scenarios
p test_pyramid_layers
p preferred_test_level(:pure_logic)
