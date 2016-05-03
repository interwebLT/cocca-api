class Contact < EPP::Model
  attr_accessor :handle, :name, :street, :city, :country_code, :voice, :email, :authcode,
                :organization, :street2, :street3, :state, :postal_code,
                :local_name, :local_organization, :local_street, :local_street2, :local_street3,
                :local_city, :local_state, :local_postal_code, :local_country_code,
                :voice_ext, :fax, :fax_ext

  validates :handle,              presence: true
  validates :local_name,          presence: true
  validates :local_street,        presence: true
  validates :local_city,          presence: true
  validates :local_country_code,  presence: true
  validates :voice,               presence: true
  validates :email,               presence: true

  def save
    return false unless valid?

    process_response client.create(create_command)
  end

  def update
    return false unless valid?

    process_response client.update(update_command)
  end

  def as_json options = nil
    {
      handle: self.handle,
      name: self.name,
      organization: self.organization,
      street: self.street,
      street2:  self.street2,
      street3:  self.street3,
      city: self.city,
      state:  self.state,
      postal_code:  self.postal_code,
      country_code: self.country_code,
      local_name: self.local_name,
      local_organization: self.local_organization,
      local_street: self.local_street,
      local_street2:  self.local_street2,
      local_street3:  self.local_street3,
      local_city: self.local_city,
      local_state:  self.local_state,
      local_postal_code:  self.local_postal_code,
      local_country_code: self.local_country_code,
      voice:  self.voice,
      voice_ext:  self.voice_ext,
      fax:  self.fax,
      fax_ext:  self.fax_ext,
      email:  self.email
    }
  end

  def create_command
    EPP::Contact::Create.new self.handle, create_params
  end

  def update_command
    EPP::Contact::Update.new self.handle, update_params
  end

  private

  def create_params
    {
      postal_info: {
        name: self.local_name,
        org:  self.local_organization,
        addr: {
          street: self.local_street,
          city: self.local_city,
          sp: self.local_state,
          pc: self.local_postal_code,
          cc: self.local_country_code
        }
      },
      voice:  self.voice,
      fax:  self.fax,
      email:  self.email,
      auth_info:  { pw: self.authcode }
    }
  end

  def update_params
    {
      chg: create_params
    }
  end
end
