# frozen_string_literal: true

def valid_order_total?(subtotal, tax)
  (subtotal + tax).positive?
end

def request_contract_ok?(status, body)
  status == 200 && body.key?(:data)
end

def system_scenarios
  ['user signs in and sees dashboard', 'user creates order and sees confirmation']
end

puts "Model spec pass? #{valid_order_total?(10, 1)}"
puts "Request spec pass? #{request_contract_ok?(200, data: { id: 1 })}"
puts "System spec scenario count: #{system_scenarios.count}"
