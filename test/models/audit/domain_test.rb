require 'test_helper'

describe Audit::Domain do
  describe :associations do
    subject { create_domain }

    specify { subject.master.wont_be_nil }
  end

  describe :domain_contacts do
    subject { create_domain }

    before do
      create_domain_contact audit_transaction: subject.audit_transaction
    end

    specify { subject.domain_contacts.count.must_equal 1 }
  end
end
