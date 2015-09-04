class Contact
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :handle, :name, :street, :city, :country_code, :voice, :email, :authcode

  validates :handle,  presence: true
  validates :name,    presence: true
  validates :street,  presence: true
  validates :city,    presence: true
  validates :country_code,  presence: true
  validates :voice,   presence: true
  validates :email,   presence: true
  validates :authcode,  presence: true

  def save
    command = EPP::Contact::Create.new self.handle, create_params
    command_response = EPP::Contact::CreateResponse.new client.create(command)

    true
  end

  private

  def client
    host  = Rails.configuration.x.epp_host
    username  = Rails.configuration.x.epp_username
    password  = Rails.configuration.x.epp_password

    EPP::Client.new username, password, host
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
end
