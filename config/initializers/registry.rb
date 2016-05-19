config = Rails.application.config_for(:registry).with_indifferent_access

Rails.configuration.x.registry_url = config[:url]
Rails.configuration.x.registry_authorization_url = config[:url] + '/authorizations' if config[:url]
