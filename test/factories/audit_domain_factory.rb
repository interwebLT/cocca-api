FactoryGirl.define do
  factory :audit_domain, class: Audit::Domain do
    audit_transaction
    audit_operation AuditOperation::INSERT_OPERATION
    roid '5-CoCCA'
    name 'domains.ph'
    exdate '2016-02-17 3:00 PM'.to_time
    clid 'alpha'
    crid 'alpha'
    createdate '2015-02-17 3:00 PM'.to_time
    zone 'ph'
    registrant 'registrant'
    authinfopw 'ABC123'

    after :create do |o|
      create :audit_master, audit_transaction: o.audit_transaction, audit_time: o.createdate
    end

    factory :register_domain do
      audit_operation AuditOperation::INSERT_OPERATION
      createdate '2015-03-07 5:00 PM'.in_time_zone

      after :create do |domain|
        create  :register_ledger, audit_transaction: domain.audit_transaction,
                                  domain_name: domain.name

        create  :audit_domain_event,  audit_transaction: domain.audit_transaction,
                                      domain_name: domain.name
      end

      factory :register_domain_in_months do
        after :create do |domain|
          domain.domain_event.update! term_length: 12, term_units: 'MONTHS'
        end
      end
    end

    factory :update_domain do
      audit_operation AuditOperation::UPDATE_OPERATION

      factory :transfer_domain do
        clid 'beta'
        createdate '2015-12-15 3:30 PM'.in_time_zone

        after :create do |domain|
          create  :transfer_ledger, audit_transaction: domain.audit_transaction,
                                    domain_name: domain.name
        end
      end

      factory :renew_domain do
        createdate '2015-03-13 07:35 AM'.in_time_zone

        after :create do |domain|
          create  :renew_ledger,  audit_transaction: domain.audit_transaction,
                                  domain_name:  domain.name

          create  :renew_domain_event,  audit_transaction: domain.audit_transaction,
                                        term_length: 3,
                                        expiry_date: domain.createdate + 3.years,
                                        domain_name: domain.name
        end

        factory :renew_domain_in_months do
          after :create do |domain|
            domain.domain_event.update! term_length: 36, term_units: 'MONTHS'
          end
        end
      end
    end
  end
end
