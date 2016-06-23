class ApplicationJob < ActiveJob::Base
  def post url, body, partner:
    owner = Partner.find_by name: partner

    request = {
      headers:  owner.headers,
      body:     body.to_json
    }

    process_response HTTParty.post url, request
  end

  def delete url, partner:
    owner = Partner.find_by name: partner

    request = {
      headers:  owner.headers
    }

    process_response HTTParty.delete url, request
  end

  def patch url, body, partner:
    owner = Partner.find_by name: partner

    request = {
      headers:  owner.headers,
      body:     body.to_json
    }

    process_response HTTParty.patch url, request
  end

  private

  def error_code code
    (400..599).include? code
  end

  def process_response response
    raise "Code: #{response.code}, Message: #{response.parsed_response}" \
      if error_code response.code

    JSON.parse response.body, symbolize_names: true
  end
end
