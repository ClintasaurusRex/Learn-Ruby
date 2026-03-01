# frozen_string_literal: true

# Lesson 03 starter routes to try in Rails app:
# Rails.application.routes.draw do
#   root "pages#home"
#   resources :posts
#   get "/health", to: "health#show"
# end

def route_signature(verb, path)
  "#{verb.upcase} #{path}"
end
