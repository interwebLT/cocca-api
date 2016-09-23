class Registry::SyncMaster < ActiveRecord::Base
  
  has_many :domains, foreign_key: :audit_transaction, class_name: Registry::SyncDomain
  has_many :contacts, foreign_key: :audit_transaction, class_name: Registry::SyncContact
  has_many :hosts, foreign_key: :audit_transaction, class_name: Registry::SyncHost
  has_many :host_addresses, foreign_key: :audit_transaction, class_name: Registry::SyncHostAddress
  has_many :domain_hosts, foreign_key: :audit_transaction, class_name: Registry::SyncDomainHost
end
