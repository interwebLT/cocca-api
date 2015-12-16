FactoryGirl.define do
  factory :audit_contact, class: Audit::Contact do
    audit_transaction
    audit_operation AuditOperation::INSERT_OPERATION
    roid '5-CoCCA'
    id 'handle'
    clid 'alpha'
    crid 'alpha'
    createdate Time.now
    intpostalname 'Contact Name'
    intpostalorg 'Contact Organization'
    intpostalstreet1 'Contact Street'
    intpostalstreet2 'Contact Street 2'
    intpostalstreet3 'Contact Street 3'
    intpostalcity 'Contact City'
    intpostalsp 'Contact State'
    intpostalpc '1234'
    intpostalcc 'PH'
    locpostalname 'Local Contact Name'
    locpostalorg 'Local Contact Organization'
    locpostalstreet1 'Local Contact Street'
    locpostalstreet2 'Local Contact Street 2'
    locpostalstreet3 'Local Contact Street 3'
    locpostalcity 'Local Contact City'
    locpostalsp 'Local Contact State'
    locpostalpc 'Local 1234'
    locpostalcc 'Local PH'
    voice '+63.21234567'
    voicex '1234'
    fax '+63.21234567'
    faxx '1235'
    email 'test@contact.ph'

    after :create do |o|
      create :audit_master, audit_transaction: o.audit_transaction
    end

    factory :update_contact do
      audit_operation AuditOperation::UPDATE_OPERATION
    end
  end
end
