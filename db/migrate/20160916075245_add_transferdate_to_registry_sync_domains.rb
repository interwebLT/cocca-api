class AddTransferdateToRegistrySyncDomains < ActiveRecord::Migration
  def change
    add_column :registry_sync_domains, :transfedate, :timestamp
  end
end
