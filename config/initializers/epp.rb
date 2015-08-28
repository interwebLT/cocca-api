config = Rails.application.config_for(:epp).with_indifferent_access

Rails.configuration.x.epp_host  = config[:host]
Rails.configuration.x.epp_username  = config[:username]
Rails.configuration.x.epp_password  = config[:password]
