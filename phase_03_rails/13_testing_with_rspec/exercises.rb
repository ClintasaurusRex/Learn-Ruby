# frozen_string_literal: true

# Exercise 1: model/unit style predicate.
def valid_order_total?(subtotal, tax)
  # TODO: return true when subtotal + tax > 0
end

# Exercise 2: request spec style contract check.
def request_contract_ok?(status, body)
  # TODO: status == 200 and include :data key
end

# Exercise 3: system spec examples list.
def system_scenarios
  # TODO: return at least two scenario strings
end

# Exercise 4: pyramid labels in order bottom->top.
def test_pyramid_layers
  # TODO: ['model', 'request', 'system']
end

# Exercise 5: choose smallest useful test level.
def preferred_test_level(change_type)
  # TODO: return model/request/system symbol
end
