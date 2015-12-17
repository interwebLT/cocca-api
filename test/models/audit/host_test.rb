require 'test_helper'

describe Audit::Host do
  subject { create :audit_host }

  describe :associations do
    specify { subject.master.wont_be_nil }
  end

  describe :host_addresses do
    context :when_host_address_exist do
      before do
        create :create_host_address, audit_transaction: subject.audit_transaction
      end

      specify { subject.host_addresses.count.must_equal 1 }
    end

    context :when_host_address_created_then_removed do
      before do
        create :create_host_address, audit_transaction: subject.audit_transaction
        create :delete_host_address, audit_transaction: subject.audit_transaction
      end

      specify { subject.host_addresses.empty?.must_equal true }
    end

    context :when_host_address_created_then_removed_test_created_again do
      before do
        create :create_host_address, audit_transaction: subject.audit_transaction
        create :delete_host_address, audit_transaction: subject.audit_transaction
        create :create_host_address, audit_transaction: subject.audit_transaction
      end

      specify { subject.host_addresses.count.must_equal 1 }
    end
  end

  describe :as_json do
    let(:expected_json) {
      {
        partner:  'alpha',
        name:     'ns5.domains.ph'
      }
    }

    specify { subject.as_json.must_equal expected_json }
  end
end
