# frozen_string_literal: true

def migration_methods
  %i[change up down]
end

def reversible_choice?(uses_change:, reversible_operation:)
  uses_change && reversible_operation
end

p migration_methods
p reversible_choice?(uses_change: true, reversible_operation: true)
