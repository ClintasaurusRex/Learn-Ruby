# frozen_string_literal: true

def crud_labels
  { create: "INSERT", read: "SELECT", update: "UPDATE", delete: "DELETE" }
end

def valid_model_setup?(has_validation:, has_scope:)
  has_validation && has_scope
end

p crud_labels
p valid_model_setup?(has_validation: true, has_scope: true)
