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
      xml = '''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
  <response>
    <result code="1000">
      <msg>Command completed successfully</msg>
    </result>
    <resData>
      <contact:creData xmlns:contact="urn:ietf:params:xml:ns:contact-1.0">
        <contact:id>contact123</contact:id>
        <contact:crDate>1999-04-03T22:00:00.0Z</contact:crDate>
      </contact:creData>
    </resData>
    <trID>
      <clTRID>ABC-12345</clTRID>
      <svTRID>54321-XYZ</svTRID>
    </trID>
  </response>
</epp>
      '''.strip

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
