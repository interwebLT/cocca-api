module EPP
  class Model
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :partner

    def client
      partner = Partner.find_by name: self.partner

      username = partner ? partner.username : Rails.configuration.x.epp_username
      password = partner ? partner.password : Rails.configuration.x.epp_password
      host  = Rails.configuration.x.epp_host

      EPP::Client.new username, password, host
    end

    def save_trid result
      trid = TrId.new
      trid.transaction_date = Time.now
      trid.tr_id = result.instance_variable_get('@xml').find('/e:epp/e:response/e:trID/e:svTRID').first.content

      trid.save
    end
  end
end
