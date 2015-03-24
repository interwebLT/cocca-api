class CreateContact
  include ActiveModel::Model

  attr_accessor :partner, :handle, :name, :organization,
                :street, :street2, :street3, :city, :state, :postal_code, :country_code,
                :voice, :email

  def self.all since:, up_to:
    ContactQuery.run(since: since, up_to: up_to).collect { |row| self.new row }
  end

  def self.sync since:, up_to:
    all(since: since, up_to: up_to).each do |record|
      SyncCreateContactJob.perform_later record.as_json
    end
  end

  def as_json options = nil
    {
      partner: self.partner,
      handle: self.handle,
      name: self.name,
      organization: self.organization,
      street: self.street,
      street2: self.street2,
      street3: self.street3,
      city: self.city,
      state: self.state,
      postal_code: self.postal_code,
      country_code: self.country_code,
      voice: self.voice,
      email: self.email
    }
  end
end
