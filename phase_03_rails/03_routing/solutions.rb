# frozen_string_literal: true

def restful_actions
  %i[index show new create edit update destroy]
end

def route_matches?(verb:, path:, expected_verb:, expected_path:)
  verb.to_s.upcase == expected_verb.to_s.upcase && path == expected_path
end

p restful_actions
p route_matches?(verb: "get", path: "/posts", expected_verb: "GET", expected_path: "/posts")
