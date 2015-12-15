FactoryGirl.define do
  factory :audit_domain_contact, class: Audit::DomainContact do
    audit_transaction
    audit_operation   AuditOperation::INSERT_OPERATION
    domain_name       'domains.ph'
    contact_id        'handle'
    type              Audit::DomainContact::ADMIN_TYPE

    factory :admin_domain_contact do
      type Audit::DomainContact::ADMIN_TYPE
      contact_id 'domain_admin'
    end

    factory :billing_domain_contact do
      type Audit::DomainContact::BILLING_TYPE
      contact_id 'domain_billing'
    end

    factory :tech_domain_contact do
      type Audit::DomainContact::TECH_TYPE
      contact_id 'domain_tech'
    end
  end
end
