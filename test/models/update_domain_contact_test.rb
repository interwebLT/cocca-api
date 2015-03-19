require 'test_helper'

describe UpdateDomainContact do
  before do
    update_domain_contact audit_time: up_to
  end

  let(:since) { '2015-03-06 13:30'.in_time_zone }
  let(:up_to) { '2015-03-06 14:00'.in_time_zone }

  describe :all do
    subject { UpdateDomainContact.all since: since, up_to: up_to }

    specify { subject.count.must_equal 1 }
    specify { subject.first.handle.must_equal 'domain_admin' }
    specify { subject.first.type.must_equal 'admin' }
  end

  describe :sync do
    before do
      stub_request(:post, authorizations_path).to_return(default_authorization_response)
      stub_request(:patch, path).to_return(status: 200)

      UpdateDomainContact.sync since: since, up_to: up_to
    end

    let(:path) { Rails.configuration.x.registry_url + '/domains/domains.ph' }

    specify { assert_requested :post, authorizations_path, body: authentication_request }
    specify { assert_requested :patch, path, body: sync_request }
  end

  private

  def sync_request
    {
      admin_handle: 'domain_admin'
    }
  end
end
