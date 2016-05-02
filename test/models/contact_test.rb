require 'test_helper'

module EPP
  module Contact
    class Command; end
    class Update < Command
      attr_reader :chg
    end
  end
end

describe Contact do
  subject { build :complete_contact }

  let(:client) { Minitest::Mock.new }

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

  describe :update_command do
    let(:chg_params) {
      {
        postal_info: {
          name: 'Local Contact',
          org:  'Local Organization',
          addr: {
            street: 'Local Street',
            city: 'Local City',
            sp: 'Local State',
            pc: 1235,
            cc: 'RP'
          }
        },
        voice:  '+63.1234567',
        fax:  '+63.1234568',
        email: 'contact@test.ph',
        auth_info: {
          pw: 'ABC123'
        }
      }
    }

    specify { subject.update_command.must_be_instance_of EPP::Contact::Update }
    specify { subject.update_command.chg.must_equal chg_params }
  end
end
