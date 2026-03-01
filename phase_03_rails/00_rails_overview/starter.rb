# frozen_string_literal: true

# Lesson 00 — Rails Overview starter
# Use these commands in terminal:
# rails new rails_overview_demo
# cd rails_overview_demo
# bin/rails generate controller Pages home
# bin/rails server

def mvc_layers
  {
    model: "Business rules and database access",
    view: "Template rendering for HTML",
    controller: "Coordinates request/response"
  }
end

# TODO: Add :router => "Maps URL + HTTP verb to controller action"
