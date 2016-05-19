FactoryGirl.define do
  factory :audit_ledger, class: Audit::Ledger do
    audit_transaction
    audit_operation 'I'
    sequence(:id, 1) { |id| id}
    client_roid 'alpha'
    description 'this is a test'
    currency 'USD'
    total 0.00
    created Time.now
    balance 0.00
    tld 'ph'

    factory :transfer_ledger, class: Audit::Ledger do
      trans_type Audit::Ledger::TRANSFER
    end

    factory :renew_ledger, class: Audit::Ledger do
      trans_type Audit::Ledger::RENEW
    end

    factory :register_ledger, class: Audit::Ledger do
      trans_type Audit::Ledger::REGISTER
    end
  end
end
