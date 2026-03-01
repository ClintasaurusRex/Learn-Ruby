# frozen_string_literal: true

# Lesson 07 migration starter commands:
# bin/rails generate migration CreateWidgets name:string active:boolean
# bin/rails db:migrate
# bin/rails db:rollback

MIGRATION_METHODS = %i[change up down].freeze

# TODO: Explain in comments when to prefer up/down.
