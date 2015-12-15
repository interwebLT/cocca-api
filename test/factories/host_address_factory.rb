FactoryGirl.define do
  factory :audit_host_address, class: Audit::HostAddress do
    audit_transaction
    audit_operation 'I'
    host_name 'ns5.domains.ph'
    ip 'v4'
    address '123.123.123.001'
  end
end
