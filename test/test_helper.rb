ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/mock'
require 'webmock/minitest'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  ::PARTNER = 'alpha'
  ::EXCLUDED_PARTNER = 'excluded'

  class << self
    alias :context :describe
  end

  def authorizations_path
   "#{Rails.configuration.x.registry_url}/authorizations"
  end

  def default_authorization_response
    default_body = { token: 'ABCDEF' }

    {
      status: 201,
      body: default_body.to_json
    }
  end

  def authentication_request
    {
      username: Rails.configuration.x.registry_username,
      password: Rails.configuration.x.registry_password
    }
  end
end

class String
  def xml
    File.read("test/assets/#{self}.xml").strip
  end

  def epp
    EPP::Response.new self.xml
  end
end
