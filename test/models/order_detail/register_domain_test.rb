require 'test_helper'

describe OrderDetail::RegisterDomain do
  subject { OrderDetail::RegisterDomain.new params }

  let(:params) {
    {
      type:     'domain_renew',
      domain:   'domain.ph',
      period:   1,
      authcode: 'ABC123',
      registrant_handle:  'registrant'
    }
  }

  describe :valid? do
    specify { subject.valid?.must_equal true }
    specify { subject.type  = nil; subject.valid?.must_equal false }
    specify { subject.domain  = nil; subject.valid?.must_equal false }
    specify { subject.period  = nil; subject.valid?.must_equal false }
    specify { subject.authcode  = nil; subject.valid?.must_equal false }
    specify { subject.registrant_handle = nil; subject.valid?.must_equal false }
  end

  describe :command do
    specify { subject.command.must_be_instance_of EPP::Domain::Create }
  end

  describe :as_json do
    let(:expected_json) {
      {
        type:   'domain_create',
        price:  0.00,
        domain: 'domain.ph',
        object: nil,
        period: 1,
        authcode: 'ABC123',
        registrant_handle:  'registrant'
      }
    }

    specify { subject.as_json.must_equal expected_json }
  end
end
