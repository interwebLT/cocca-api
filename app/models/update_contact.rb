class UpdateContact
  include ActiveModel::Model

  def self.all since:, up_to:
    ContactQuery.run(since: since, up_to: up_to, audit_operation: 'U').collect do |row|
      CreateContact.new(row)
    end
  end

  def self.sync since:, up_to:
    all(since: since, up_to: up_to).each do |record|
      SyncUpdateContactJob.perform_later record.as_json
    end
  end
end
