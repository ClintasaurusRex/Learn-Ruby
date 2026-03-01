#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$ROOT_DIR/rails_api_app"

if [ -d "$APP_DIR" ]; then
  echo "rails_api_app already exists at $APP_DIR"
  exit 0
fi

rails new "$APP_DIR" --api -T
cd "$APP_DIR"

echo "gem 'rspec-rails', group: [:development, :test]" >> Gemfile
bundle install
bin/rails generate rspec:install

bin/rails generate model User email:string password_digest:string auth_token:string
bin/rails generate scaffold Post title:string body:text user:references
bin/rails generate controller Auth signup login

bin/rails db:create db:migrate

echo "API scaffold complete: $APP_DIR"
