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
