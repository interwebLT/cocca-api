def audit_master audit_time, partner: 'alpha'
  master = create :audit_master,  audit_time: audit_time,
                                  audit_user: partner,
                                  audit_login: partner

  master.audit_transaction
end

def update_domain audit_time: Time.now, partner: PARTNER
  audit_transaction = audit_master audit_time, partner: partner

  create :audit_domain, audit_transaction: audit_transaction, audit_operation: 'U'
end

def update_domain_contact audit_time: Time.now, partner: PARTNER
  create :audit_domain_contact, audit_transaction: audit_master(audit_time, partner: partner)
end

def create_contact audit_time: Time.now, partner: PARTNER
  create :audit_contact, audit_transaction: audit_master(audit_time, partner: partner)
end

def update_contact audit_time: Time.now, partner: PARTNER
  create :audit_contact,  audit_transaction: audit_master(audit_time, partner: partner),
                          audit_operation: 'U'
end

def create_domain_host audit_time: Time.now, partner: PARTNER
  create :audit_domain_host, audit_transaction: audit_master(audit_time, partner: partner)
end

def remove_domain_host audit_time: Time.now, partner: PARTNER
  create :remove_domain_host, audit_transaction: audit_master(audit_time, partner: partner)
end

def create_host_address audit_time: Time.now, partner: PARTNER
  create :audit_host_address, audit_transaction: audit_master(audit_time, partner: partner)
end

def remove_host_address name: 'ns5.domains.ph', audit_time: Time.now, partner: PARTNER
  create :audit_host_address, audit_transaction: audit_master(audit_time, partner: partner),
                              audit_operation: 'D'
end

def create_host audit_time: Time.now, partner: PARTNER
  create :audit_host, audit_transaction: audit_master(audit_time, partner: partner)
end
