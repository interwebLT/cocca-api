require 'test_helper'

describe CreateContact do
  before do
    create_contact audit_time: up_to
  end

  let(:since) { '2015-03-06 13:30'.in_time_zone }
  let(:up_to) { '2015-03-06 14:00'.in_time_zone }

  describe :all do
    subject { CreateContact.all since: since, up_to: up_to }

    specify { subject.count.must_equal 1 }
    specify { subject.first.partner.must_equal 'alpha' }
    specify { subject.first.handle.must_equal 'handle' }
    specify { subject.first.name.must_equal 'Contact Name' }
    specify { subject.first.organization.must_equal 'Contact Organization' }
    specify { subject.first.street.must_equal 'Contact Street' }
    specify { subject.first.street2.must_equal 'Contact Street 2' }
    specify { subject.first.street3.must_equal 'Contact Street 3' }
    specify { subject.first.city.must_equal 'Contact City' }
    specify { subject.first.state.must_equal 'Contact State' }
    specify { subject.first.postal_code.must_equal '1234' }
    specify { subject.first.country_code.must_equal 'PH' }
    specify { subject.first.voice.must_equal '+63.21234567' }
    specify { subject.first.voice_ext.must_equal '1234' }
    specify { subject.first.fax.must_equal '+63.21234567' }
    specify { subject.first.fax_ext.must_equal '1235' }
    specify { subject.first.email.must_equal 'test@contact.ph' }
  end

  describe :sync do
    before do
      stub_request(:post, authorizations_path).to_return(default_authorization_response)
      stub_request(:post, path).to_return(status: 200)

      CreateContact.sync since: since, up_to: up_to
    end

    let(:path) { Rails.configuration.x.registry_url + '/contacts' }

    specify { assert_requested :post, authorizations_path, body: authentication_request }
    specify { assert_requested :post, path, body: sync_request }
  end

  private

  def sync_request
    {
      partner: 'alpha',
      handle: 'handle',
      name: 'Contact Name',
      organization: 'Contact Organization',
      street: 'Contact Street',
      street2: 'Contact Street 2',
      street3: 'Contact Street 3',
      city: 'Contact City',
      state: 'Contact State',
      postal_code: '1234',
      country_code: 'PH',
      voice: '+63.21234567',
      voice_ext: '1234',
      fax: '+63.21234567',
      fax_ext: '1235',
      email: 'test@contact.ph'
    }
  end
end
