# frozen_string_literal: true

# =============================================================================
# rails_service_object_template.rb
#
# Service object pattern for Rails.
# Use when a controller action needs more than 5-10 lines of logic,
# or when logic needs to be reused across multiple controllers/jobs.
#
# Pattern:
#   result = MyService.call(arg1, arg2)
#   result.success?  # => true or false
#   result.value     # => the return value on success
#   result.errors    # => array of error messages on failure
#
# Usage:
#   Copy this file to app/services/
#   Rename the class to match the operation (e.g., PublishPostService)
# =============================================================================

class ExampleService
  # ---------------------------------------------------------------------------
  # Result — a simple value object for the service's return value.
  # Keeps the interface consistent: always check success? first.
  # ---------------------------------------------------------------------------
  Result = Struct.new(:success?, :value, :errors, keyword_init: true) do
    def failure?
      !success?
    end
  end

  # ---------------------------------------------------------------------------
  # .call — the public entry point.
  # Instantiates the service and calls it in one step.
  # This is the only method callers need to know about.
  # ---------------------------------------------------------------------------
  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  # ---------------------------------------------------------------------------
  # Constructor — receives the service's dependencies.
  # Keep this simple: just store what you need.
  # ---------------------------------------------------------------------------
  def initialize(user:, resource:)
    @user     = user
    @resource = resource
  end

  # ---------------------------------------------------------------------------
  # #call — the main logic.
  # Returns a Result struct (never raises, never returns raw values).
  # ---------------------------------------------------------------------------
  def call
    # Step 1: Check authorization
    return failure("Not authorized") unless authorized?

    # Step 2: Validate the resource
    return failure("Resource is invalid: #{validation_errors}") unless valid?

    # Step 3: Do the work
    perform_operation

    # Step 4: Trigger side effects
    notify_user
    log_activity

    # Step 5: Return success
    success(@resource)
  rescue StandardError => e
    # Catch unexpected errors — don't let them bubble up unchecked
    failure("Unexpected error: #{e.message}")
  end

  private

  # ---------------------------------------------------------------------------
  # Authorization check — does this user have permission?
  # ---------------------------------------------------------------------------
  def authorized?
    # TODO: replace with your authorization logic
    @user.present? && (@user == @resource.owner || @user.admin?)
  end

  # ---------------------------------------------------------------------------
  # Validation — is the resource in a valid state for this operation?
  # ---------------------------------------------------------------------------
  def valid?
    # TODO: replace with your validation logic
    @resource.valid?
  end

  def validation_errors
    @resource.errors.full_messages.join(", ")
  end

  # ---------------------------------------------------------------------------
  # Core operation — the actual work this service does
  # ---------------------------------------------------------------------------
  def perform_operation
    # TODO: replace with your operation
    @resource.update!(processed: true, processed_at: Time.current)
  end

  # ---------------------------------------------------------------------------
  # Side effects — triggered after success
  # ---------------------------------------------------------------------------
  def notify_user
    # TODO: replace with notification logic (email, push, etc.)
    # UserMailer.operation_complete(@user, @resource).deliver_later
  end

  def log_activity
    # TODO: replace with activity logging
    # ActivityLog.create!(user: @user, resource: @resource, action: "processed")
    Rails.logger.info "ExampleService: processed #{@resource.class}##{@resource.id} by User##{@user.id}"
  end

  # ---------------------------------------------------------------------------
  # Result helpers — keep return values consistent
  # ---------------------------------------------------------------------------
  def success(value)
    Result.new(success?: true, value: value, errors: [])
  end

  def failure(message)
    Result.new(success?: false, value: nil, errors: Array(message))
  end
end

# =============================================================================
# Controller usage example (do not include in the service file itself)
# =============================================================================
#
# class PostsController < ApplicationController
#   def publish
#     result = PublishPostService.call(user: current_user, resource: @post)
#
#     if result.success?
#       redirect_to @post, notice: "Post published!"
#     else
#       flash[:alert] = result.errors.join(", ")
#       redirect_to @post
#     end
#   end
# end
