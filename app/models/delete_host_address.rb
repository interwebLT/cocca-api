class DeleteHostAddress
  include ActiveModel::Model

  attr_accessor :host, :address, :type

  def self.all since:, up_to:
    HostAddressQuery.run(since: since, up_to: up_to, audit_operation: 'D').collect do |row|
      self.new row
    end
  end

  def self.sync since:, up_to:
    self.all(since: since, up_to: up_to).each do |record|
      SyncDeleteHostAddressJob.perform_later record.as_json
    end
  end
end
