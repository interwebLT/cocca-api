require 'test_helper'

describe CreateHostAddress do
  before do
    host_address = create :create_host_address
    host_address.master.update audit_time: up_to
  end

  let(:since) { '2015-03-04 14:00'.in_time_zone }
  let(:up_to) { '2015-03-04 14:30'.in_time_zone }

  describe :all do
    subject { CreateHostAddress.all since: since, up_to: up_to }

    specify { subject.count.must_equal 1 }
    specify { subject.first.host.must_equal 'ns5.domains.ph' }
    specify { subject.first.address.must_equal '123.123.123.001' }
    specify { subject.first.type.must_equal 'v4' }
  end

  describe :sync do
    before do
      stub_request(:post, authorizations_path).to_return(default_authorization_response)
      stub_request(:post, path).to_return(status: 201)

      CreateHostAddress.sync since: since, up_to: up_to
    end

    let(:path) { Rails.configuration.x.registry_url + '/hosts/ns5.domains.ph/addresses' }

    specify { assert_requested :post, authorizations_path, body: authentication_request }
    specify { assert_requested :post, path, body: create_host_address_request }
  end

  private

  def create_host_address_request
    {
      address: '123.123.123.001',
      type: 'v4'
    }
  end
end
