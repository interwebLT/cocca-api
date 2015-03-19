require 'test_helper'

describe DeleteDomainHost do
  before do
    remove_domain_host audit_time: up_to
  end

  let(:since) { '2015-03-04 14:00'.in_time_zone }
  let(:up_to) { '2015-03-04 14:30'.in_time_zone }

  describe :all do
    subject { DeleteDomainHost.all since: since, up_to: up_to }

    specify { subject.count.must_equal 1 }
    specify { subject.first.partner.must_equal 'alpha' }
    specify { subject.first.domain.must_equal 'domains.ph' }
    specify { subject.first.host.must_equal 'ns5.domains.ph' }
  end

  describe :sync do
    before do
      stub_request(:post, authorizations_path).to_return(default_authorization_response)
      stub_request(:delete, path).to_return(status: 200)

      DeleteDomainHost.sync since: since, up_to: up_to
    end

    let(:path) { Rails.configuration.x.registry_url + '/domains/domains.ph/hosts/ns5.domains.ph' }

    specify { assert_requested :post, authorizations_path, body: authentication_request }
    specify { assert_requested :delete, path }
  end
end
