FactoryGirl.define do
  factory :audit_host_address, class: Audit::HostAddress do
    audit_transaction
    audit_operation 'I'
    host_name 'ns5.domains.ph'
    ip 'v4'
    address '123.123.123.001'
  end
end

def create_host_address audit_time: Time.now
  create :audit_host_address, audit_transaction: audit_master(audit_time)
end

def remove_host_address name: 'ns5.domains.ph', audit_time: Time.now
  create :audit_host_address, audit_transaction: audit_master(audit_time), audit_operation: 'D'
end
