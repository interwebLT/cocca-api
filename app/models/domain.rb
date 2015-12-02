class Domain < EPP::Model
  attr_accessor :name

  validates :name,  presence: true

  def update_authcode registrant, authcode
    result = client.update(update_authcode_command(registrant, authcode))

    save_trid result

    valid? && result.success?
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
