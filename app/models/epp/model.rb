module EPP
  class Model
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :partner

    validates :partner, presence: true

    def client
      partner = Partner.find_by name: self.partner

      username = partner ? partner.username : Rails.configuration.x.epp_username
      password = partner ? partner.password : Rails.configuration.x.epp_password
      host  = Rails.configuration.x.epp_host

      @clients ||= {}
      @clients[username] = EPP::Client.new username, password, host unless @clients.include? username

      @clients[username]
    end

    def process_response response
      errors.add(:epp, response.message) unless response.success?

      response.success?
    end
  end
end
