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

  def exists? name:
    response  = client.check check_command(name)
    check     = EPP::Domain::CheckResponse.new response

    not check.available? name
  end

  private

  def check_command domain
    EPP::Domain::Check.new(domain)
  end
end
