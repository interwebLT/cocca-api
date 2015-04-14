Given /^registry accepts sync requests$/ do
  registry_accepts_sync_requests
end

Given /^some partners are excluded from sync$/ do
  exclude_partners
end

Given /^I registered a domain$/ do
  create_domain partner: EXCLUDED_PARTNER

  create_domain
end

Given /^I created a contact$/ do
  create_contact partner: EXCLUDED_PARTNER

  create_contact
end

Given /^I created a host entry$/ do
  create_host
end

Given /^I added a host address to an existing host$/ do
  create_host_address
end

Given /^I removed a host address from an existing host$/ do
  remove_host_address
end

Given /^I added a domain host entry to an existing domain$/ do
  create_domain_host
end

Given /^I removed a domain host entry from an existing domain$/ do
  remove_domain_host
end

Given /^I updated an existing contact$/ do
  update_contact
end

Given /^I updated an existing domain$/ do
  update_domain
end

Given /^I updated a contact of an existing domain$/ do
  update_domain_contact
end

Given /^I renewed a domain$/ do
  renew_domain
end

When /^latest changes are synced$/ do
  sync_latest_changes
end

When /^syncing of latest changes results in an error$/ do
  sync_error
end

Then /^domain must now be registered$/ do
  assert_register_domain_synced
end

Then /^contact must now exist$/ do
  assert_create_contact_synced
end

Then /^host entry must now exist$/ do
  assert_create_host_entry_synced
end

Then /^host must now have the host address I associated with it$/ do
  assert_create_host_address_synced
end

Then /^host must no longer have the host address I removed associated with it$/ do
  assert_remove_host_address_synced
end

Then /^domain must now have the domain host entry I associated with it$/ do
  assert_create_domain_host_entry_synced
end

Then /^domain must no longer have the domain host entry I removed associated with it$/ do
  assert_remove_domain_host_entry_synced
end

Then /^contact must be updated$/ do
  assert_update_contact_synced
end

Then /^domain must be updated$/ do
  assert_update_domain_synced
end

Then /^domain contact must be updated$/ do
  assert_update_domain_contact_synced
end

Then /^I must be informed of the error$/ do
  assert_exception_thrown
end

Then /^domain must now be renewed$/ do
  assert_renew_domain_synced
end


