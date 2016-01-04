require 'test_helper'

describe OrderDetail::RenewDomain do
  subject { OrderDetail::RenewDomain.new params }

  let(:params) {
    {
      type:   'domain_renew',
      domain: 'domain.ph',
      period: 1,
      current_expires_at: '2016-01-04T17:30:00Z'
    }
  }

  describe :valid? do
    specify { subject.valid?.must_equal true }
    specify { subject.type  = nil; subject.valid?.must_equal false }
    specify { subject.domain  = nil; subject.valid?.must_equal false }
    specify { subject.period  = nil; subject.valid?.must_equal false }
  end

  describe :command do
    specify { subject.command.must_be_instance_of EPP::Domain::Renew }
  end

  describe :as_json do
    let(:expected_json) {
      {
        type:   'domain_renew',
        price:  0.00,
        domain: 'domain.ph',
        object: nil,
        period: 1,
        current_expires_at: '2016-01-04T17:30:00Z'
      }
    }

    specify { subject.as_json.must_equal expected_json }
  end
end
