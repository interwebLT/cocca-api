FactoryGirl.define do
  trait :audit_transaction do
    sequence(:audit_transaction, 1) { |audit_transaction| audit_transaction }
  end

  factory :audit_master, class: Audit::Master  do
    audit_transaction
    audit_user 'alpha'
    audit_login 'alpha'
    audit_time Time.now
    audit_ip '127.0.0.1'
  end

  factory :audit_ledger, class: Audit::Ledger do
    audit_transaction
    audit_operation 'I'
    sequence(:id, 1) { |id| id}
    client_roid '3-CoCCA'
    description 'this is a test'
    currency 'USD'
    total 0.00
    created Time.now
    balance 0.00
    tld 'ph'

    factory :transfer_ledger, class: Audit::Ledger do
      trans_type 'Transfer'
    end
  end
end

def audit_master audit_time, partner: 'alpha'
  master = create :audit_master,  audit_time: audit_time,
                                  audit_user: partner,
                                  audit_login: partner

  master.audit_transaction
end
