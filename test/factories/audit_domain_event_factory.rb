FactoryGirl.define do
  factory :audit_domain_event, class: Audit::DomainEvent do
    audit_transaction
    audit_operation 'I'
    sequence(:id, 1) { |id| id}
    domain_roid '5-CoCCA'
    domain_name @domain
    client_clid 'alpha'
    event 'REGISTRATION'
    term_length 1
    term_units 'YEAR'
    expiry_date 1.to_i.year.from_now
    ledger_id 1
    login_username 'admin'

    factory :renew_domain_event, class: Audit::DomainEvent do
      event 'RENEWAL'
    end
  end
end
