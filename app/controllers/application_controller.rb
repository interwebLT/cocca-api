class ApplicationController < ActionController::API
  def not_found
    {
      status: :not_found,
      json: { message: 'Not Found' }
    }
  end

  def validation_failed object
    errors = object.errors.collect do |attribute, error|
      {
        field: attribute,
        code: error
      }
    end

    result = {
      status: :unprocessable_entity,
      json: {
        message: 'Validation Failed',
        errors: errors
      }
    }
  end
end
