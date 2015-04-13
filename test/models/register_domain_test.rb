require 'test_helper'

describe RegisterDomain do
  before do
    create_domain audit_time: up_to
  end

  let(:since) { '2015-03-06 13:30'.in_time_zone }
  let(:up_to) { '2015-03-06 14:00'.in_time_zone }

  describe :all do
    subject { RegisterDomain.all since: since, up_to: up_to }

    specify { subject.count.must_equal 1 }
    specify { subject.first.partner.must_equal 'alpha' }
    specify { subject.first.currency_code.must_equal 'USD' }
    specify { subject.first.domain.must_equal 'domains.ph' }
    specify { subject.first.authcode.must_equal 'ABC123' }
    specify { subject.first.period.must_equal '1' }
    specify { subject.first.registrant_handle.must_equal 'registrant' }
    specify { subject.first.registered_at.must_equal '2015-03-07 17:00'.in_time_zone }
  end

  describe :sync do
    before do
      stub_request(:post, authorizations_path).to_return(default_authorization_response)
      stub_request(:post, path).to_return(status: 200)

      RegisterDomain.sync since: since, up_to: up_to
    end

    let(:path) { Rails.configuration.x.registry_url + '/orders' }

    specify { assert_requested :post, authorizations_path, body: authentication_request }
    specify { assert_requested :post, path, body: sync_request }
  end

  private

  def sync_request
    {
      partner: 'alpha',
      currency_code: 'USD',
      order_details: [
        {
          type: 'domain_create',
          domain: 'domains.ph',
          authcode: 'ABC123',
          period: 1,
          registrant_handle: 'registrant',
          registered_at: '2015-03-07T09:00:00Z'
        }
      ]
    }
  end
end
