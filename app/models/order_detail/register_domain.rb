class OrderDetail::RegisterDomain < OrderDetail
  TYPE = 'domain_create'

  attr_accessor :authcode, :registrant_handle

  validates :authcode,  presence: true
  validates :registrant_handle, presence: true

  def save
    return false unless valid?

    response = client.create command
    save_trid response

    response.success?
  end

  def command
    EPP::Domain::Create.new self.domain, command_params
  end

  def as_json
    {
      type: TYPE,
      price:  0.00,
      domain: self.domain,
      object: nil,
      authcode: self.authcode,
      period: self.period,
      registrant_handle:  self.registrant_handle
    }
  end

  private

  def command_params
    {
      period: "#{self.period}y",
      registrant: self.registrant_handle,
      auth_info:  { pw: self.authcode },
      contacts: {
        admin: '',
        tech: '',
        billing: ''
        },
      nameservers: []
    }
  end
end
