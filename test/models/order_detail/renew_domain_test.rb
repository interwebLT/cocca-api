require 'test_helper'

describe OrderDetail::RenewDomain do
  subject { OrderDetail::RenewDomain.new params }

  let(:params) {
    {
      type:   'domain_renew',
      domain: 'domain.ph',
      period: 1
    }
  }

  describe :command do
    specify { subject.command.must_be_instance_of EPP::Domain::Renew }
  end
end
