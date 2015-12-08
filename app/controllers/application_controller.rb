class ApplicationController < ActionController::API
  def not_found
    {
      status: :not_found,
      json: { message: 'Not Found' }
    }
  end
end
