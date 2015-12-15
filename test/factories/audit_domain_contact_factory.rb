FactoryGirl.define do
  factory :audit_domain_contact, class: Audit::DomainContact do
    audit_transaction
    audit_operation 'I'
    domain_name 'domains.ph'
    contact_id 'domain_admin'
    type 'admin'
  end
end
