require 'test_helper'

describe Audit::Domain do
  describe :associations do
    subject { create_domain }

    specify { subject.master.wont_be_nil }
  end

  describe :domain_contacts do
    subject { create_domain }

    context :when_contact_exists do
      before do
        create_domain_contact audit_transaction: subject.audit_transaction
      end

      specify { subject.domain_contacts.count.must_equal 1 }
    end

    context :when_contact_created_then_removed do
      before do
        create_domain_contact audit_transaction: subject.audit_transaction
        remove_domain_contact audit_transaction: subject.audit_transaction
      end

      specify { subject.domain_contacts.empty?.must_equal true }
    end

    context :when_contact_created_then_removed_then_created_again do
      before do
        create_domain_contact audit_transaction: subject.audit_transaction
        remove_domain_contact audit_transaction: subject.audit_transaction
        create_domain_contact audit_transaction: subject.audit_transaction
      end

      specify { subject.domain_contacts.count.must_equal 1 }
    end
  end
end
