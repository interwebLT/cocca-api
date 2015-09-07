module EPP
  class Model
    include ActiveModel::Model
    include ActiveModel::Validations

    def client
      host  = Rails.configuration.x.epp_host
      username  = Rails.configuration.x.epp_username
      password  = Rails.configuration.x.epp_password

      EPP::Client.new username, password, host
    end
  end
end
