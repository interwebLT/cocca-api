require 'test_helper'

describe Contact do
  subject {
    Contact.new handle: 'contact123',
                name: 'Contact',
                street: 'Street',
                city: 'City',
                country_code: 'PH',
                voice:  '+63.1234567',
                email:  'contact@test.ph',
                authcode: 'ABC123'
  }

  describe :valid? do
    specify { subject.valid?.must_equal true }
    specify { Contact.new.valid?.must_equal false }
    specify { subject.handle = nil; subject.valid?.must_equal false }
    specify { subject.name= nil;    subject.valid?.must_equal false }
    specify { subject.street = nil; subject.valid?.must_equal false }
    specify { subject.city = nil;   subject.valid?.must_equal false }
    specify { subject.country_code = nil; subject.valid?.must_equal false }
    specify { subject.voice = nil;  subject.valid?.must_equal false }
    specify { subject.email = nil;  subject.valid?.must_equal false }
    specify { subject.authcode= nil;  subject.valid?.must_equal false }
  end

  describe :save do
    let(:client) { Minitest::Mock.new }

    before do
      client.expect :create,  EPP::Response.new('contact/create_response'.xml),
                              [EPP::Contact::Create]
    end

    specify do
      EPP::Client.stub :new, client do
        subject.save.must_equal true
      end
    end
  end

  describe :as_json do
    let(:expected_json) {
      {
        handle: 'contact123',
        name: 'Contact',
        organization: nil,
        street: 'Street',
        street2:  nil,
        street3:  nil,
        city: 'City',
        state:  nil,
        postal_code:  nil,
        country_code: 'PH',
        local_name: nil,
        local_organization: nil,
        local_street: nil,
        local_street2:  nil,
        local_street3:  nil,
        local_city: nil,
        local_state:  nil,
        local_postal_code:  nil,
        local_country_code: nil,
        voice:  '+63.1234567',
        voice_ext:  nil,
        fax:  nil,
        fax_ext:  nil,
        email:  'contact@test.ph'
      }
    }

    specify { subject.as_json.must_equal expected_json }
  end
end
