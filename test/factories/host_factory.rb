FactoryGirl.define do
  factory :audit_host, class: Audit::Host do
    audit_transaction
    audit_operation 'I'
    roid 1
    name 'ns5.domains.ph'
    clid 'alpha'
    crid 'alpha'
    createdate Time.now
  end
end
