module Sync
  def self.run
    since = SyncLog.last_run
    up_to = Audit::Master.latest_time

    SyncLog.create since: since, until: up_to

    CreateContact.sync        since: since, up_to: up_to
    UpdateContact.sync        since: since, up_to: up_to

    Audit::Master.transactions(since: since, up_to: up_to).each do |master|
      master.domains.each do |domain|
        RegisterDomainJob.perform_later(domain.as_json) if domain.audit_operation == 'I'
      end
    end

    CreateHost.sync           since: since, up_to: up_to
    DeleteHostAddress.sync    since: since, up_to: up_to
    CreateHostAddress.sync    since: since, up_to: up_to

    UpdateDomain.sync         since: since, up_to: up_to
    UpdateDomainContact.sync  since: since, up_to: up_to

    DeleteDomainHost.sync     since: since, up_to: up_to
    CreateDomainHost.sync     since: since, up_to: up_to

    RenewDomain.sync          since: since, up_to: up_to
  end
end
