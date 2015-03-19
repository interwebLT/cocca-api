FactoryGirl.define do
  factory :audit_contact, class: Audit::Contact do
    audit_transaction
    audit_operation 'I'
    roid '5-CoCCA'
    id 'handle'
    clid 'alpha'
    crid 'alpha'
    createdate Time.now
    locpostalname 'Contact Name'
    locpostalorg 'Contact Organization'
    locpostalstreet1 'Contact Street'
    locpostalcity 'Contact City'
    locpostalsp 'Contact State'
    locpostalpc '1234'
    locpostalcc 'PH'
    voice '+63.21234567'
    fax '+63.21234567'
    email 'test@contact.ph'
  end
end

def create_contact audit_time: Time.now
  create :audit_contact, audit_transaction: audit_master(audit_time)
end

def update_contact audit_time: Time.now
  create :audit_contact, audit_transaction: audit_master(audit_time), audit_operation: 'U'
end
