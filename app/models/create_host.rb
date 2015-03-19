class CreateHost
  include ActiveModel::Model

  attr_accessor :partner, :name

  def self.all since:, up_to:
    HostQuery.run(since: since, up_to: up_to).collect { |row| self.new row }
  end

  def self.sync since:, up_to:
    all(since: since, up_to: up_to).each do |record|
     SyncCreateHostJob.perform_later record.as_json
    end
  end

  def as_json options = nil
    {
      partner: self.partner,
      name: self.name
    }
  end
end
