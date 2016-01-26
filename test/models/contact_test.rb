require 'test_helper'

describe Contact do
  subject { build :contact }

  let(:client) { Minitest::Mock.new }

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
    context :when_required_fields_present do
      before do
        client.expect :create, 'contact/create_response'.epp, [EPP::Contact::Create]
      end

      specify do
        EPP::Client.stub :new, client do
          subject.save.must_equal true
        end
      end
    end

    context :when_required_fields_missing do
      subject { Contact.new }

      specify { subject.save.must_equal false }
    end

    context :when_create_command_fails do
      before do
        client.expect :create, 'contact/create_failed_response'.epp, [EPP::Contact::Create]
      end

      specify do
        EPP::Client.stub :new, client do
          subject.save.must_equal false
          subject.errors[:epp].must_equal ['Missing required fields']
        end
      end
    end
  end

  describe :update do
    context :when_update_command_fails do
      before do
        client.expect :update, 'contact/update_failed_response'.epp, [EPP::Contact::Update]
      end

      specify do
        EPP::Client.stub :new, client do
          subject.update.must_equal false
          subject.errors[:epp].must_equal ['Missing required fields']
        end
      end
    end
  end

  describe :as_json do
    subject { build :complete_contact }

    let(:expected_json) {
      {
        handle: 'contact123',
        name: 'Contact',
        organization: 'Organization',
        street: 'Street',
        street2:  'Street 2',
        street3:  'Street 3',
        city: 'City',
        state:  'State',
        postal_code:  1234,
        country_code: 'PH',
        local_name: 'Local Contact',
        local_organization: 'Local Organization',
        local_street: 'Local Street',
        local_street2:  'Local Street 2',
        local_street3:  'Local Street 3',
        local_city: 'Local City',
        local_state:  'Local State',
        local_postal_code:  1235,
        local_country_code: 'RP',
        voice:  '+63.1234567',
        voice_ext:  1234,
        fax:  '+63.1234568',
        fax_ext:  1235,
        email:  'contact@test.ph'
      }
    }

    specify { subject.as_json.must_equal expected_json }
  end
end
