class CreateDomainHost
  include ActiveModel::Model

  attr_accessor :partner, :domain, :host

  def self.all since:, up_to:
    DomainHostQuery.run(since: since, up_to: up_to, audit_operation: 'I').collect do |row|
      self.new row
    end
  end

  def self.sync since:, up_to:
    self.all(since: since, up_to: up_to).each do |record|
      SyncCreateDomainHostJob.perform_later record.as_json
    end
  end

  def as_json options = nil
    {
      domain: self.domain,
      name: self.host
    }
  end
end
