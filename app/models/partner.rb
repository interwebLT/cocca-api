class Partner < ActiveRecord::Base
  alias_attribute :username, :name

  validates :name,  presence: true
  validates :password,  presence: true

  def headers
    {
      'Content-Type'  => 'application/json',
      'Accept'        => 'application/json',
      'Authorization' => "Token token=#{token}"
    }
  end
end
