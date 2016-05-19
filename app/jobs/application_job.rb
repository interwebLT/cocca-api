class ApplicationJob < ActiveJob::Base
  DEFAULT_HEADERS = {
    'Content-Type'  => 'application/json',
    'Accept'        => 'application/json'
  }

  def execute action, partner:, path:, body: nil
    partner = Partner.find_by name: partner
    token   = partner.nil? ? nil : partner.token

    params = {}.tap do |params|
      params[:headers]  = headers token: token
      params[:body]     = body.to_json if body
    end

    response = HTTParty.send action, path, params

    raise "Code: #{response.code}, Message: #{response.parsed_response}" if error_code response.code
  end

  private

  def error_code code
    (400..599).include? code
  end

  def headers token: nil
    DEFAULT_HEADERS.tap do |headers|
      headers['Authorization'] = "Token token=#{token}" if token
    end
  end
end
