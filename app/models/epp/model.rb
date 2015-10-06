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

    def save_trid result
      trid = TrId.new
      trid.transaction_date = Time.now 
      trid.tr_id = result.instance_variable_get('@xml').find('/e:epp/e:response/e:trID/e:svTRID').first.content

      trid.save
    end
  end
end
