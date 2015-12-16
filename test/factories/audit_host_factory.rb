FactoryGirl.define do
  factory :audit_host, class: Audit::Host do
    audit_transaction
    audit_operation AuditOperation::INSERT_OPERATION
    roid 1
    name 'ns5.domains.ph'
    clid 'alpha'
    crid 'alpha'
    createdate Time.now

    after :create do |o|
      create :audit_master, audit_transaction: o.audit_transaction
    end
  end
end
