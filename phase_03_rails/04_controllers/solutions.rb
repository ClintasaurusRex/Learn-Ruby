# frozen_string_literal: true

def action_result(success)
  success ? :redirect : :render
end

def callback_chain
  %i[before_action action render_response]
end

p action_result(true)
p callback_chain
