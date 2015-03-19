require 'test_helper'

describe DeleteHostAddress do
  before do
    remove_host_address audit_time: up_to
  end

  let(:since) { '2015-03-04 14:00'.in_time_zone }
  let(:up_to) { '2015-03-04 14:30'.in_time_zone }

  describe :all do
    subject { DeleteHostAddress.all since: since, up_to: up_to }

    specify { subject.count.must_equal 1 }
    specify { subject.first.host.must_equal 'ns5.domains.ph' }
    specify { subject.first.address.must_equal '123.123.123.001' }
    specify { subject.first.type.must_equal 'v4' }
  end

  describe :sync do
    before do
      stub_request(:post, authorizations_path).to_return(default_authorization_response)
      stub_request(:delete, path).to_return(status: 200)

      DeleteHostAddress.sync since: since, up_to: up_to
    end

    let(:path) {
      Rails.configuration.x.registry_url + '/hosts/ns5.domains.ph/addresses/123.123.123.001'
    }

    specify { assert_requested :post, authorizations_path, body: authentication_request }
    specify { assert_requested :delete, path }
  end
end
