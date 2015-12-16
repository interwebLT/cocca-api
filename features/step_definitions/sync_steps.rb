Given /^registry accepts sync requests$/ do
  registry_response with: 201, on: AUTHORIZATIONS_PATH, body: { token: 'ABCDEF' }

  registry_response with: 201, on: ORDERS_PATH
  registry_response with: 201, on: CONTACTS_PATH
  registry_response with: 201, on: HOSTS_PATH

  registry_response with: 201, on: HOST_ADDRESS_PATH
  registry_response with: 200, on: HOST_ADDRESS_PATH, request: :delete

  registry_response with: 201, on: DOMAIN_HOST_PATH

  registry_response with: 200, on: DOMAIN_PATH, request: :patch
  registry_response with: 200, on: DOMAIN_PATH, request: :delete

  registry_response with: 200, on: CONTACT_PATH, request: :patch
end

Given /^some partners are excluded from sync$/ do
  exclude_partners
end

Given /^I registered a domain$/ do
  create :register_domain
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
  domain = create :register_domain
  create :create_domain_host, audit_transaction: domain.audit_transaction
end

Given /^I removed a domain host entry from an existing domain$/ do
  domain = create :register_domain
  create :remove_domain_host, audit_transaction: domain.audit_transaction
end

Given /^I updated an existing contact$/ do
  update_contact partner: EXCLUDED_PARTNER

  update_contact
end

Given /^I updated an existing domain$/ do
  create :update_domain
end

Given /^I updated a contact of an existing domain$/ do
  domain = create :update_domain
  create :admin_domain_contact, audit_transaction: domain.audit_transaction
end

Given /^I renewed a domain$/ do
  create :renew_domain
end

Given /^I registered a domain with period in months$/ do
  create :register_domain_in_months
end

Given /^I renewed a domain with period in months$/ do
  create :renew_domain_in_months
end

Given /^I transferred a domain into my partner account$/ do
  create :transfer_domain
end

When /^latest changes are synced$/ do
  run_sync
end

When /^syncing of latest changes results in an error$/ do
  registry_response with: 400, on: ORDERS_PATH, body: error_params

  run_sync
end

Then /^domain must now be registered$/ do
  assert_post '/orders', 'order/sync_register_domain_request'.json
end

Then /^contact must now exist$/ do
  assert_post '/contacts', 'contact/sync_create_request'.json
end

Then /^host entry must now exist$/ do
  assert_post '/hosts', 'host/sync_create_request'.json
end

Then /^host must now have the host address I associated with it$/ do
  assert_post '/hosts/ns5.domains.ph/addresses', 'host_address/sync_create_request'.json
end

Then /^host must no longer have the host address I removed associated with it$/ do
  assert_delete '/hosts/ns5.domains.ph/addresses/123.123.123.001'
end

Then /^domain must now have the domain host entry I associated with it$/ do
  assert_post '/domains/domains.ph/hosts', 'domain_host/sync_create_request'.json
end

Then /^domain must no longer have the domain host entry I removed associated with it$/ do
  assert_delete '/domains/domains.ph/hosts/ns5.domains.ph'
end

Then /^contact must be updated$/ do
  assert_patch '/contacts/handle', 'contact/sync_update_request'.json
end

Then /^domain must be updated$/ do
  assert_patch '/domains/domains.ph', 'domain/sync_update_request'.json
end

Then /^domain contact must be updated$/ do
  assert_patch '/domains/domains.ph', 'domain/sync_update_contact_request'.json
end

Then /^I must be informed of the error$/ do
  @exception_thrown.must_equal true
end

Then /^domain must now be renewed$/ do
  assert_post '/orders', 'order/sync_renew_domain_request'.json
end

Then /^domain must now be under my partner$/ do
  assert_post '/orders', 'order/sync_transfer_domain_request'.json
end
