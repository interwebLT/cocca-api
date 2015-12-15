require 'test_helper'

describe Audit::Domain do
  describe :associations do
    subject { create_domain }

    specify { subject.master.wont_be_nil }
    specify { subject.domain_event.wont_be_nil }
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

    context :when_different_types do
      before do
        create_domain_contact audit_transaction: subject.audit_transaction

        remove_domain_contact audit_transaction: subject.audit_transaction,
                              type: Audit::DomainContact::BILLING_TYPE
      end

      specify { subject.domain_contacts.count.must_equal 2 }
    end

    context :when_different_domains do
      before do
        create :domain_contact, audit_transaction: subject.audit_transaction,
                                domain_name: 'domains.ph'

        create :domain_contact, audit_transaction: subject.audit_transaction,
                                domain_name: 'domains.com.ph'
      end

      specify { subject.domain_contacts.count.must_equal 1 }
    end
  end

  describe :as_json do
    subject { register_domain }

    before do
      create :create_domain_host, audit_transaction:  subject.audit_transaction,
                                  host_name:          'ns5.domains.ph'

      create :remove_domain_host, audit_transaction:  subject.audit_transaction,
                                  host_name:          'ns6.domains.ph'

      create :admin_domain_contact,   audit_transaction: subject.audit_transaction
      create :billing_domain_contact, audit_transaction: subject.audit_transaction
      create :tech_domain_contact,    audit_transaction: subject.audit_transaction
    end

    let(:expected_json) {
      {
        partner:                    'alpha',
        domain:                     'domains.ph',
        authcode:                   'ABC123',
        period:                     1,
        registrant_handle:          'registrant',
        ordered_at:                 '2015-03-07T17:00:00Z',
        client_hold:                false,
        client_delete_prohibited:   false,
        client_renew_prohibited:    false,
        client_transfer_prohibited: false,
        client_update_prohibited:   false,
        admin_handle:               'handle',
        billing_handle:             'handle',
        tech_handle:                'handle',
        domain_hosts: [
          {
            audit_operation:  AuditOperation::DELETE_OPERATION,
            host:             'ns6.domains.ph'
          },
          {
            audit_operation:  AuditOperation::INSERT_OPERATION,
            host:             'ns5.domains.ph'
          }
        ]
      }
    }

    specify { subject.as_json.must_equal expected_json }

    context :when_transfer_domain do
      subject { create :transfer_domain }

      specify { subject.as_json[:partner].must_equal 'beta' }
    end
  end

  let(:register_domain) { create :register_domain }
  let(:renew_domain)    { create :renew_domain }
  let(:update_domain)   { create :update_domain }
  let(:transfer_domain) { create :transfer_domain }

  describe :register_domain? do
    specify { register_domain.register_domain?.must_equal true }
    specify { update_domain.register_domain?.must_equal false }
    specify { renew_domain.register_domain?.must_equal false }
    specify { transfer_domain.register_domain?.must_equal false }
  end

  describe :update_domain? do
    specify { update_domain.update_domain?.must_equal true }
    specify { register_domain.update_domain?.must_equal false }
    specify { renew_domain.update_domain?.must_equal false }
    specify { transfer_domain.update_domain?.must_equal false }
  end

  describe :renew_domain? do
    specify { renew_domain.renew_domain?.must_equal true }
    specify { register_domain.renew_domain?.must_equal false }
    specify { update_domain.renew_domain?.must_equal false }
    specify { transfer_domain.renew_domain?.must_equal false }
  end

  describe :transfer_domain? do
    specify { transfer_domain.transfer_domain?.must_equal true }
    specify { register_domain.transfer_domain?.must_equal false }
    specify { update_domain.transfer_domain?.must_equal false }
    specify { renew_domain.transfer_domain?.must_equal false }
  end

  describe :domain_hosts do
    subject { create_domain }

    context :when_host_exists do
      before do
        create :create_domain_host, audit_transaction: subject.audit_transaction
      end

      specify { subject.domain_hosts.count.must_equal 1 }
    end

    context :when_host_created_then_removed do
      before do
        create :create_domain_host, audit_transaction: subject.audit_transaction
        create :remove_domain_host, audit_transaction: subject.audit_transaction
      end

      specify { subject.domain_hosts.empty?.must_equal true }
    end

    context :when_contact_created_then_removed_then_created_again do
      before do
        create :create_domain_host, audit_transaction: subject.audit_transaction
        create :remove_domain_host, audit_transaction: subject.audit_transaction
        create :create_domain_host, audit_transaction: subject.audit_transaction
      end

      specify { subject.domain_hosts.count.must_equal 1 }
    end

    context :when_different_domains do
      before do
        create :create_domain_host, audit_transaction:  subject.audit_transaction,
                                    domain_name:        'domains.ph'

        create :remove_domain_host, audit_transaction:  subject.audit_transaction,
                                    domain_name:        'domains.com.ph'
      end

      specify { subject.domain_hosts.count.must_equal 1 }
    end
  end
end
