class ApplicationJob < ActiveJob::Base
  DEFAULT_HEADERS = {
    'Content-Type'  => 'application/json',
    'Accept'        => 'application/json'
  }

  def execute action, path:, body: nil
    token = authenticate

    raise 'Authentication Failed' unless token

    params = {}.tap do |params|
      params[:headers]  = headers token: token
      params[:body]     = body.to_json if body
    end

    response = HTTParty.send action, path, params

    raise "Code: #{response.code}, Message: #{response.parsed_response}" if error_code response.code
  end

  private

  def authenticate
    response = HTTParty.post  Rails.configuration.x.registry_authorization_url,
                              headers: headers,
                              body: authentication_request.to_json

    json_response = JSON.parse response.body, symbolize_names: true

    json_response[:token] unless error_code response.code
  end

  def authentication_request
    {
      username: Rails.configuration.x.registry_username,
      password: Rails.configuration.x.registry_password
    }
  end

  def error_code code
    (400..599).include? code
  end

  def headers token: nil
    DEFAULT_HEADERS.tap do |headers|
      headers['Authorization'] = "Token token=#{token}" if token
    end
  end
end
