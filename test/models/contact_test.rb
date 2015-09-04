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
      xml = File.read('test/assets/contact/create_response.xml').strip

      client.expect :create, EPP::Response.new(xml), [EPP::Contact::Create]
    end

    specify {
      EPP::Client.stub :new, client do
        @result = subject.save
      end

      @result.must_equal true
    }
  end
end
