FactoryGirl.define do
  factory :domain_contact, class: Audit::DomainContact, aliases: [:admin_domain_contact] do
    audit_transaction
    audit_operation   AuditOperation::INSERT_OPERATION
    domain_name       'domains.ph'
    contact_id        'handle'
    type              Audit::DomainContact::ADMIN_TYPE

    factory :billing_domain_contact do
      type Audit::DomainContact::BILLING_TYPE
    end

    factory :tech_domain_contact do
      type Audit::DomainContact::TECH_TYPE
    end
  end
end

def create_domain_contact audit_transaction:
  create :domain_contact, audit_transaction: audit_transaction
end

def remove_domain_contact audit_transaction:, type: Audit::DomainContact::ADMIN_TYPE
  create :domain_contact, audit_transaction:  audit_transaction,
                          audit_operation:    'D',
                          type: type
end
