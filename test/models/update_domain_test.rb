require 'test_helper'

describe UpdateDomain do
  before do
    update_domain audit_time: up_to
  end

  let(:since) { '2015-03-06 13:30'.in_time_zone }
  let(:up_to) { '2015-03-06 14:00'.in_time_zone }

  describe :all do
    subject { UpdateDomain.all since: since, up_to: up_to }

    specify { subject.count.must_equal 1 }
    specify { subject.first.domain.must_equal 'domains.ph' }
    specify { subject.first.registrant.must_equal 'registrant' }
    specify { subject.first.authcode.must_equal 'ABC123' }
    specify { subject.first.client_hold.must_equal false }
    specify { subject.first.client_delete_prohibited.must_equal false }
    specify { subject.first.client_renew_prohibited.must_equal false }
    specify { subject.first.client_transfer_prohibited.must_equal false }
    specify { subject.first.client_update_prohibited.must_equal false }
  end

  describe :sync do
    before do
      stub_request(:post, authorizations_path).to_return(default_authorization_response)
      stub_request(:patch, path).to_return(status: 200)

      UpdateDomain.sync since: since, up_to: up_to
    end

    let(:path) { Rails.configuration.x.registry_url + '/domains/domains.ph' }

    specify { assert_requested :post, authorizations_path, body: authentication_request }
    specify { assert_requested :patch, path, body: sync_request }
  end

  private

  def sync_request
    {
      registrant_handle: 'registrant',
      authcode: 'ABC123',
      client_hold: false,
      client_delete_prohibited: false,
      client_renew_prohibited: false,
      client_transfer_prohibited: false,
      client_update_prohibited: false
    }
  end
end
