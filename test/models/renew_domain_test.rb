require 'test_helper'

describe RenewDomain do
  before do
    renew_domain audit_time: up_to
  end

  let(:since) { '2015-03-06 13:30'.in_time_zone }
  let(:up_to) { '2015-03-06 14:00'.in_time_zone }

  describe :all do
    subject { RenewDomain.all since: since, up_to: up_to }

    specify { subject.count.must_equal 1 }
    specify { subject.first.partner.must_equal 'alpha' }
    specify { subject.first.currency_code.must_equal 'USD' }
    specify { subject.first.domain.must_equal 'domains.ph' }
    specify { subject.first.period.must_equal '3' }
    specify { subject.first.renewed_at.must_equal up_to }
  end

  describe :sync do
    before do
      stub_request(:post, authorizations_path).to_return(default_authorization_response)
      stub_request(:post, path).to_return(status: 200)

      RenewDomain.sync since: since, up_to: up_to
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
          type: 'domain_renew',
          domain: 'domains.ph',
          period: 3,
          renewed_at: '2015-03-06T06:00:00Z'
        }
      ]
    }
  end

end
