# frozen_string_literal: true

def important_paths
  {
    routes: "config/routes.rb",
    controllers: "app/controllers",
    views: "app/views",
    migrations: "db/migrate"
  }
end

def valid_structure?(paths)
  required = %i[routes controllers views migrations]
  required.all? { |key| paths.key?(key) }
end

p important_paths
p valid_structure?(important_paths)
