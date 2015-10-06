class Contact < EPP::Model
  attr_accessor :handle, :name, :street, :city, :country_code, :voice, :email, :authcode,
                :organization, :street2, :street3, :state, :postal_code,
                :local_name, :local_organization, :local_street, :local_street2, :local_street3,
                :local_city, :local_state, :local_postal_code, :local_country_code,
                :voice_ext, :fax, :fax_ext

  validates :handle,  presence: true
  validates :name,    presence: true
  validates :street,  presence: true
  validates :city,    presence: true
  validates :country_code,  presence: true
  validates :voice,   presence: true
  validates :email,   presence: true
  validates :authcode,  presence: true

  def save
    response = client.create(create_command)

    save_trid response

    valid? && response.success?
  end

  def update
    response = client.update(update_command)

    save_trid response

    valid? && response.success?
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

  private

  def create_command
    EPP::Contact::Create.new self.handle, create_params
  end

  def update_command
    EPP::Contact::Update.new self.handle, update_params
  end

  def create_params
    {
      postal_info: {
        name: self.name,
        org:  nil,
        addr: {
          street: self.street,
          city: self.city,
          sp: nil,
          pc: nil,
          cc: self.country_code
        }
      },
      voice:  self.voice,
      fax:  nil,
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
