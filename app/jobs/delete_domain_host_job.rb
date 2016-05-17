class DeleteDomainHostJob < ApplicationJob
  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform partner, record
    execute :delete,  partner:  partner,
                      path:     "#{URL}/domains/#{record[:domain]}/hosts/#{record[:host]}"
  end
end
