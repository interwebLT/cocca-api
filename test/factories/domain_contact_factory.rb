FactoryGirl.define do
  factory :domain_contact, class: Audit::DomainContact do
    audit_transaction
    audit_operation 'I'
    domain_name 'domains.ph'
    contact_id  'handle'
    type  'admin'
  end
end

def create_domain_contact audit_transaction:
  create :domain_contact, audit_transaction: audit_transaction
end
