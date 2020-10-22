class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token

  # rescue_from(<error-class>, with: <method-name>)
  # Use rescue_from in a controller to prevent an error of class <error-class> 
  # from crashing our app and have <method-name> handle the error
  rescue_from(StandardError, with: :standard_error)
  rescue_from(ActiveRecord::RecordInvalid, with: :record_invalid)

  def not_found 
    render(
      json: {
        errors: [{
          type: "Not Found"
        }]
      },
      status: :not_found # alias for 404 in rails
    )
  end

  private

  def authenticate_user!
    unless current_user.present?
      render(json: { status: 401 }, status: 401)
    end
  end

  protected
  # protected is like private except that it also prevents
  # descendent classes from using methods defined within

  def record_invalid(error)
    # For a ActiveRecord::RecordInvalid error, the .record method 
    # returns the model instance that failed validation
    invalid_record = error.record
    errors = invalid_record.errors.map do |field, message|
      {
        type: error.class.to_s,
        record_type: error.record.class.to_s,
        field: field,
        message: message
      }
    end
    render(
      json: {
        errors: errors
      },
      status: :unprocessable_entity # alias for status 422
    ) 
  end

  def standard_error(error)
    # Log exception backtrace to the console
    logger.error error.backtrace.join("\r\n")

    render(
      json: {
        errors: [{
          type: error.class.to_s,
          message: error.message
        }]
      },
      status: :internal_server_error # alias from status 500
    )
  end
end
