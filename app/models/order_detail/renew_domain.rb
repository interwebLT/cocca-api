class OrderDetail::RenewDomain < OrderDetail
  TYPE = 'domain_renew'

  def command
    EPP::Domain::Renew.new self.domain, '2015-01-01', "#{self.period}y"
  end

  def as_json options = nil
    {
      type: self.type,
      price:  0.00,
      domain: self.domain,
      object: nil,
      period: self.period
    }
  end
end
