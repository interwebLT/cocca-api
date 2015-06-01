FactoryGirl.define do
  factory :audit_domain_host, class: Audit::DomainHost, aliases: [:create_domain_host] do
    audit_transaction
    audit_operation 'I'
    domain_name     'domains.ph'
    host_name       'ns5.domains.ph'

    factory :remove_domain_host do
      audit_operation 'D'
    end
  end
end

def create_domain_host audit_time: Time.now, partner: PARTNER
  create :audit_domain_host, audit_transaction: audit_master(audit_time, partner: partner)
end

def remove_domain_host audit_time: Time.now, partner: PARTNER
  create :remove_domain_host, audit_transaction: audit_master(audit_time, partner: partner)
end
