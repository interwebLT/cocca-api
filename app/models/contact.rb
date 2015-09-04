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
    true
  end
end
