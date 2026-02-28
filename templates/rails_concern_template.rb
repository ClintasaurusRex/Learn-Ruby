# frozen_string_literal: true

# =============================================================================
# rails_concern_template.rb
#
# ActiveSupport::Concern template.
# Use concerns to share behavior across multiple models or controllers
# without deep inheritance chains.
#
# For models: place in app/models/concerns/
# For controllers: place in app/controllers/concerns/
#
# Usage:
#   class Post < ApplicationRecord
#     include Publishable
#   end
# =============================================================================

module Publishable
  extend ActiveSupport::Concern

  # ---------------------------------------------------------------------------
  # included — runs when the module is included in a class.
  # Use this block to add class-level behavior (scopes, validations, callbacks).
  # ---------------------------------------------------------------------------
  included do
    # Validations
    validates :status, inclusion: { in: %w[draft published archived] }

    # Scopes
    scope :published, -> { where(status: "published") }
    scope :drafts,    -> { where(status: "draft") }
    scope :archived,  -> { where(status: "archived") }
    scope :recent,    -> { order(published_at: :desc) }

    # Callbacks
    before_save :set_published_at, if: :publishing?

    # Attributes (if your model has these columns)
    attribute :status, :string, default: "draft"
  end

  # ---------------------------------------------------------------------------
  # ClassMethods — methods added to the class (not instances) when included.
  # Access them as: Post.by_status("published")
  # ---------------------------------------------------------------------------
  module ClassMethods
    def by_status(status)
      where(status: status)
    end

    def published_between(start_date, end_date)
      published.where(published_at: start_date..end_date)
    end
  end

  # ---------------------------------------------------------------------------
  # Instance methods — added to each instance of the including class.
  # Access them as: post.publish!
  # ---------------------------------------------------------------------------

  def publish!
    return false if published?

    update!(status: "published", published_at: Time.current)
  end

  def unpublish!
    return false unless published?

    update!(status: "draft", published_at: nil)
  end

  def archive!
    update!(status: "archived")
  end

  def published?
    status == "published"
  end

  def draft?
    status == "draft"
  end

  def archived?
    status == "archived"
  end

  def status_label
    case status
    when "published" then "✓ Published"
    when "draft"     then "✎ Draft"
    when "archived"  then "✗ Archived"
    else status.capitalize
    end
  end

  private

  def publishing?
    status_changed? && status == "published" && published_at.nil?
  end

  def set_published_at
    self.published_at = Time.current
  end
end

# =============================================================================
# Controller concern example — place in app/controllers/concerns/
# =============================================================================
#
# module Authenticatable
#   extend ActiveSupport::Concern
#
#   included do
#     before_action :require_login
#     helper_method :current_user, :logged_in?
#   end
#
#   def current_user
#     @current_user ||= User.find_by(id: session[:user_id])
#   end
#
#   def logged_in?
#     current_user.present?
#   end
#
#   private
#
#   def require_login
#     redirect_to login_path, alert: "Please log in." unless logged_in?
#   end
# end
