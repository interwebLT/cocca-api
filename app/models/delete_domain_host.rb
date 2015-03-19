class DeleteDomainHost
  include ActiveModel::Model

  attr_accessor :partner, :domain, :host

  def self.sync since:, up_to:
    self.all(since: since, up_to: up_to).each do |record|
      SyncDeleteDomainHostJob.perform_later record.as_json
    end
  end

  def self.all since:, up_to:
    DomainHostQuery.run(since: since, up_to: up_to, audit_operation: 'D').collect do |row|
      self.new row
    end
  end
end
