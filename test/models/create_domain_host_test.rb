require 'test_helper'

describe CreateDomainHost do
  before do
    create_domain_host audit_time: up_to
  end

  let(:since) { '2015-03-04 14:00'.in_time_zone }
  let(:up_to) { '2015-03-04 14:30'.in_time_zone }

  describe :all do
    subject { CreateDomainHost.all since: since, up_to: up_to }

    specify { subject.count.must_equal 1 }
    specify { subject.first.partner.must_equal 'alpha' }
    specify { subject.first.domain.must_equal 'domains.ph' }
    specify { subject.first.host.must_equal 'ns5.domains.ph' }
  end

  describe :sync do
    before do
      stub_request(:post, authorizations_path).to_return(default_authorization_response)
      stub_request(:post, path).to_return(status: 201)

      CreateDomainHost.sync since: since, up_to: up_to
    end

    let(:path) { Rails.configuration.x.registry_url + '/domains/domains.ph/hosts' }

    specify { assert_requested :post, authorizations_path, body: authentication_request }
    specify { assert_requested :post, path, body: sync_request }
  end

  private

  def sync_request
    {
      name: 'ns5.domains.ph'
    }
  end
end
