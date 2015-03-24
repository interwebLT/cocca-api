class CreateContact
  include ActiveModel::Model

  attr_accessor :partner, :handle,
                :name, :organization, :street, :street2, :street3,
                :city, :state, :postal_code, :country_code,
                :local_name, :local_organization, :local_street, :local_street2, :local_street3,
                :local_city, :local_state, :local_postal_code, :local_country_code,
                :voice, :voice_ext, :fax, :fax_ext, :email

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
      local_name: self.local_name,
      local_organization: self.local_organization,
      local_street: self.local_street,
      local_street2: self.local_street2,
      local_street3: self.local_street3,
      local_city: self.local_city,
      local_state: self.local_state,
      local_postal_code: self.local_postal_code,
      local_country_code: self.local_country_code,
      voice: self.voice,
      voice_ext: self.voice_ext,
      fax: self.fax,
      fax_ext: self.fax_ext,
      email: self.email
    }
  end
end
