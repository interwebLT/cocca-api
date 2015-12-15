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
  create_host partner: EXCLUDED_PARTNER

  create_host
end

Given /^I added a host address to an existing host$/ do
  create_host_address partner: EXCLUDED_PARTNER

  create_host_address
end

Given /^I removed a host address from an existing host$/ do
  remove_host_address partner: EXCLUDED_PARTNER

  remove_host_address
end

Given /^I added a domain host entry to an existing domain$/ do
  create_domain_host partner: EXCLUDED_PARTNER

  domain = create_domain
  create :create_domain_host, audit_transaction: domain.audit_transaction
end

Given /^I removed a domain host entry from an existing domain$/ do
  remove_domain_host partner: EXCLUDED_PARTNER

  domain = create_domain
  create :remove_domain_host, audit_transaction: domain.audit_transaction
end

Given /^I updated an existing contact$/ do
  update_contact partner: EXCLUDED_PARTNER

  update_contact
end

Given /^I updated an existing domain$/ do
  update_domain partner: EXCLUDED_PARTNER

  update_domain
end

Given /^I updated a contact of an existing domain$/ do
  update_domain_contact partner: EXCLUDED_PARTNER

  domain = update_domain
  create :admin_domain_contact, audit_transaction: domain.audit_transaction
end

Given /^I renewed a domain$/ do
  renew_domain partner: EXCLUDED_PARTNER

  renew_domain
end

Given /^I requested to transfer a domain$/ do
  transfer_domain_request
end

Given /^I registered a domain with period in months$/ do
  register_domain_with_period_in_months
end

Given /^I renewed a domain with period in months$/ do
  renew_domain_with_period_in_months
end

When /^latest changes are synced$/ do
  sync_latest_changes
end

When /^syncing of latest changes results in an error$/ do
  sync_error
end

Then /^domain must now be registered$/ do
  assert_post '/orders', 'order/sync_register_domain_request'.json
end

Then /^contact must now exist$/ do
  assert_post '/contacts', create_contact_request
end

Then /^host entry must now exist$/ do
  assert_post '/hosts', create_host_request
end

Then /^host must now have the host address I associated with it$/ do
  assert_post '/hosts/ns5.domains.ph/addresses', create_host_address_request
end

Then /^host must no longer have the host address I removed associated with it$/ do
  assert_delete '/hosts/ns5.domains.ph/addresses/123.123.123.001'
end

Then /^domain must now have the domain host entry I associated with it$/ do
  assert_post '/domains/domains.ph/hosts', create_domain_host_entry_request
end

Then /^domain must no longer have the domain host entry I removed associated with it$/ do
  assert_delete '/domains/domains.ph/hosts/ns5.domains.ph'
end

Then /^contact must be updated$/ do
  assert_patch '/contacts/handle', update_contact_request
end

Then /^domain must be updated$/ do
  assert_patch '/domains/domains.ph', update_domain_request
end

Then /^domain contact must be updated$/ do
  assert_patch '/domains/domains.ph', update_domain_contact_request
end

Then /^I must be informed of the error$/ do
  @exception_thrown.must_equal true
end

Then /^domain must now be renewed$/ do
  assert_post '/orders', 'order/sync_renew_domain_request'.json
end

Then /^no request must be sent$/ do
  assert_not_requested :patch, DOMAIN_PATH
end
