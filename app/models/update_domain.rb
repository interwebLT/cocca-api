class UpdateDomain
  include ActiveModel::Model

  attr_accessor :domain, :registrant,
                :client_hold, :client_delete_prohibited, :client_renew_prohibited,
                :client_transfer_prohibited, :client_update_prohibited

  def self.all since:, up_to:
    UpdateDomainQuery.run(since: since, up_to: up_to).collect { |row| self.new row }
  end

  def self.sync since:, up_to:
    all(since: since, up_to: up_to).each do |record|
      SyncUpdateDomainJob.perform_later record.as_json
     end
  end

  def as_json options = nil
    {
      domain: self.domain,
      registrant_handle: self.registrant,
      client_hold: self.client_hold,
      client_delete_prohibited: self.client_delete_prohibited,
      client_renew_prohibited: self.client_renew_prohibited,
      client_transfer_prohibited: self.client_transfer_prohibited,
      client_update_prohibited: self.client_update_prohibited
    }
  end
end
