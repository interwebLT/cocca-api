require 'test_helper'

describe Domain do
  let(:client) { Minitest::Mock.new }

  describe :update_authcode do
    subject { Domain.new name: domain }

    let(:domain) { 'domain.ph' }
    let(:registrant) { 'contact' }
    let(:authcode) { 'ABC123' }

    before do
      client.expect :update, 'domain/update_authcode_response'.epp, [EPP::Domain::Update]
    end

    specify do
      EPP::Client.stub :new, client do
        subject.update_authcode(registrant, authcode).must_equal true
      end
    end
  end
end
