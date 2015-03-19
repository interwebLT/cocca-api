module SyncJob
  extend ActiveSupport::Concern

  def execute(action, path:, body: nil)
    token = authenticate

    if token
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Token token=\"#{token}\""
      }

      params = { headers: headers }
      params[:body] = body.to_json if body

      response = HTTParty.send action, path, params

      raise "Code: #{response.code}, Message: #{response.parsed_response}" if error_code response.code
    else
      raise 'Authentication Failed'
    end
  end

  private

  def authenticate
    request = {
         username: Rails.configuration.x.registry_username,
         password: Rails.configuration.x.registry_password
    }

    response = HTTParty.post  Rails.configuration.x.registry_authorization_url,
                              headers: { 'Content-Type' => 'application/json' },
                              body: request.to_json

    json_response = JSON.parse response.body, symbolize_names: true

    json_response[:token] unless error_code response.code
  end

  def error_code code
    (400..599).include? code
  end
end
