class AddDomainServerFlags < ActiveRecord::Migration
  def change
    add_column :audit_domain, :st_sv_deleteprohibited,    :string, limit: 1024
    add_column :audit_domain, :st_sv_hold,                :string, limit: 1024
    add_column :audit_domain, :st_sv_renewprohibited,     :string, limit: 1024
    add_column :audit_domain, :st_sv_transferprohibited,  :string, limit: 1024
    add_column :audit_domain, :st_sv_updateprohibited,    :string, limit: 1024
  end
end
