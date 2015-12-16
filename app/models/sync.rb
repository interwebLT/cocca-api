module Sync
  def self.run
    since = SyncLog.last_run
    up_to = Audit::Master.latest_time

    SyncLog.create since: since, until: up_to

    records = Audit::Master.transactions since: since, up_to: up_to

    records.each do |master|
      master.contacts.each do |contact|
        CreateContactJob.perform_later contact.as_json if contact.insert_operation?
        UpdateContactJob.perform_later contact.as_json if contact.update_operation?
      end

      master.domains.each do |domain|
        RegisterDomainJob.perform_later domain.as_json if domain.register_domain?
        RenewDomainJob.perform_later    domain.as_json if domain.renew_domain?
        TransferDomainJob.perform_later domain.as_json if domain.transfer_domain?
      end

      master.hosts.each do |host|
        CreateHostJob.perform_later host.as_json  if host.insert_operation?

        host.host_addresses.each do |host_address|
          CreateHostAddressJob.perform_later host_address.as_json  if host_address.insert_operation?
          DeleteHostAddressJob.perform_later host_address.as_json  if host_address.delete_operation?
        end
      end
    end

    records.each do |master|
      master.domains.each do |domain|
        UpdateDomainJob.perform_later domain.as_json if domain.update_domain?

        domain.domain_hosts.each do |domain_host|
          CreateDomainHostJob.perform_later domain_host.as_json if domain_host.insert_operation?
          DeleteDomainHostJob.perform_later domain_host.as_json if domain_host.delete_operation?
        end
      end
    end
  end
end
