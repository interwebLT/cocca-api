class Domain < EPP::Model
  attr_accessor :name, :registrant_handle, :authcode

  validates :name,  presence: true
  validates :registrant_handle, presence: true

  def update_authcode authcode
    return false unless valid?

    client.update(update_authcode_command(self.registrant_handle, authcode)).success?
  end

  def update_authcode_command registrant, authcode
    EPP::Domain::Update.new self.name, {
        chg: {
          registrant: registrant,
          auth_info: {
            pw: authcode
          }
        }
      }
  end
end
