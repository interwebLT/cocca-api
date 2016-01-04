class OrderDetail::RenewDomain < OrderDetail
  attr_accessor :type, :domain, :period

  def command
    EPP::Domain::Renew.new self.domain, '2015-01-01', "#{self.period}y"
  end
end
