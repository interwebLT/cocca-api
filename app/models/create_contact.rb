class CreateContact
  include ActiveModel::Model

  attr_accessor :partner, :handle, :name, :organization,
                :street, :city, :state, :postal_code, :country_code, :phone, :email

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
      city: self.city,
      state: self.state,
      postal_code: self.postal_code,
      country_code: self.country_code,
      phone: self.phone,
      email: self.email
    }
  end
end
