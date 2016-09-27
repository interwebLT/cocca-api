class Registry::SyncDomainHost < ActiveRecord::Base

  belongs_to :master, foreign_key: :audit_transaction, primary_key: :audit_transaction, class_name: Registry::SyncMaster

end
