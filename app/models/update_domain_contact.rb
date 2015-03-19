class UpdateDomainContact
  include ActiveModel::Model

  attr_accessor :domain, :handle, :type, :audit_operation

  def self.all since:, up_to:
    UpdateDomainContactQuery.run(since: since, up_to: up_to).collect { |row| self.new row }
  end

  def self.sync since:, up_to:
    all(since: since, up_to: up_to).each do |record|
      SyncUpdateDomainJob.perform_later record.as_json
    end
  end

  def as_json options = nil
    if self.audit_operation == 'D'
      handle = nil
    else
      handle = self.handle
    end

    {
      domain: self.domain,
      "#{self.type}_handle".to_sym => handle
    }
  end
end
