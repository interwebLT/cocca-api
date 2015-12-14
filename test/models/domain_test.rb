require 'test_helper'

describe Domain do
  let(:client) { Minitest::Mock.new }

  let(:params) {
    {
      name: 'domain.ph',
      partner:  'alpha',
      registrant_handle: 'contact'
    }
  }

  describe :valid? do
    subject { Domain.new params }

    specify { subject.valid?.must_equal true }
    specify { subject.name = nil; subject.valid?.must_equal false }
    specify { subject.registrant_handle = nil; subject.valid?.must_equal false }
  end

  describe :update_authcode do
    subject { Domain.new params }

    let(:authcode) { 'ABC123' }

    before do
      client.expect :update, 'domain/update_authcode_response'.epp, [EPP::Domain::Update]
    end

    specify do
      EPP::Client.stub :new, client do
        subject.update_authcode(authcode).must_equal true
      end
    end
  end
end
