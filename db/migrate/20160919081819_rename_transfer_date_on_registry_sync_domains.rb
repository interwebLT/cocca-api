class RenameTransferDateOnRegistrySyncDomains < ActiveRecord::Migration
  def change
    rename_column :registry_sync_domains, :transfedate, :transferdate
  end
end
