FactoryGirl.define do
  factory :audit_contact, class: Audit::Contact do
    audit_transaction
    audit_operation 'I'
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
  end
end

def create_contact audit_time: Time.now, partner: PARTNER
  create :audit_contact, audit_transaction: audit_master(audit_time, partner: partner)
end

def update_contact audit_time: Time.now, partner: PARTNER
  create :audit_contact,  audit_transaction: audit_master(audit_time, partner: partner),
                          audit_operation: 'U'
end
