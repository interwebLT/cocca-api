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
  FactoryGirl.create :register_domain
end

Given /^I created a contact$/ do
  FactoryGirl.create :audit_contact
end

Given /^I created a host entry$/ do
  FactoryGirl.create :audit_host
end

Given /^I added a host address to an existing host$/ do
  FactoryGirl.create :create_host_address
end

Given /^I removed a host address from an existing host$/ do
  FactoryGirl.create :delete_host_address
end

Given /^I added a domain host entry to an existing domain$/ do
  domain = FactoryGirl.create :register_domain
  FactoryGirl.create :create_domain_host, audit_transaction: domain.audit_transaction
end

Given /^I removed a domain host entry from an existing domain$/ do
  domain = FactoryGirl.create :register_domain
  FactoryGirl.create :delete_domain_host, audit_transaction: domain.audit_transaction
end

Given /^I updated an existing contact$/ do
  FactoryGirl.create :update_contact
end

Given /^I updated an existing domain$/ do
  FactoryGirl.create :update_domain
end

Given /^I updated a contact of an existing domain$/ do
  domain = FactoryGirl.create :update_domain
  FactoryGirl.create :admin_domain_contact, audit_transaction: domain.audit_transaction
end

Given /^I renewed a domain$/ do
  FactoryGirl.create :renew_domain
end

Given /^I registered a domain with period in months$/ do
  FactoryGirl.create :register_domain_in_months
end

Given /^I renewed a domain with period in months$/ do
  FactoryGirl.create :renew_domain_in_months
end

Given /^I transferred a domain into my partner account$/ do
  FactoryGirl.create :transfer_domain
end

Given /^I registered a domain from an excluded IP$/ do
  FactoryGirl.create :excluded_ip

  domain = FactoryGirl.create :register_domain
  domain.master.update! audit_ip: EXCLUDED_IP
end

Given /^I deleted an existing domain$/ do
  FactoryGirl.create :delete_domain
end

When /^latest changes are synced$/ do
  run_sync
end

When /^syncing of latest changes results in an error$/ do
  registry_response with: 400, on: ORDERS_PATH, body: error_params

  run_sync
end

Then /^domain must now be registered$/ do
  expect(WebMock).to have_requested(:post, url('/orders'))
    .with headers: default_headers, body: 'order/sync_register_domain_request'.json
end

Then /^contact must now exist$/ do
  expect(WebMock).to have_requested(:post, url('/contacts'))
    .with headers: default_headers, body: 'contact/sync_create_request'.json
end

Then /^host entry must now exist$/ do
  expect(WebMock).to have_requested(:post, url('/hosts'))
    .with headers: default_headers, body: 'host/sync_create_request'.json
end

Then /^host must now have the host address I associated with it$/ do
  expect(WebMock).to have_requested(:post, url('/hosts/ns5.domains.ph/addresses'))
    .with headers: default_headers, body: 'host_address/sync_create_request'.json
end

Then /^host must no longer have the host address I removed associated with it$/ do
  expect(WebMock).to have_requested(:delete, url('/hosts/ns5.domains.ph/addresses/123.123.123.001'))
    .with headers: default_headers
end

Then /^domain must now have the domain host entry I associated with it$/ do
  expect(WebMock).to have_requested(:post, url('/domains/domains.ph/hosts'))
    .with headers: default_headers, body: 'domain_host/sync_create_request'.json
end

Then /^domain must no longer have the domain host entry I removed associated with it$/ do
  expect(WebMock).to have_requested(:delete, url('/domains/domains.ph/hosts/ns5.domains.ph'))
    .with headers: default_headers
end

Then /^contact must be updated$/ do
  expect(WebMock).to have_requested(:patch, url('/contacts/handle'))
    .with headers: default_headers, body: 'contact/sync_update_request'.json
end

Then /^domain must be updated$/ do
  expect(WebMock).to have_requested(:patch, url('/domains/domains.ph'))
    .with headers: default_headers, body: 'domain/sync_update_request'.json
end

Then /^domain contact must be updated$/ do
  expect(WebMock).to have_requested(:patch, url('/domains/domains.ph'))
    .with headers: default_headers, body: 'domain/sync_update_contact_request'.json
end

Then /^I must be informed of the error$/ do
  expect(@exception_thrown).to be true
end

Then /^domain must now be renewed$/ do
  expect(WebMock).to have_requested(:post, url('/orders'))
    .with headers: default_headers, body: 'order/sync_renew_domain_request'.json
end

Then /^domain must now be under my partner$/ do
  expect(WebMock).to have_requested(:post, url('/orders'))
    .with headers: default_headers, body: 'order/sync_transfer_domain_request'.json
end

Then /^no changes must be synced$/ do
  assert_not_requested :post, Rails.configuration.x.registry_url + '/orders'
end

Then /^domain must now be deleted$/ do
  expect(WebMock).to have_requested(:delete, url('/domains/domains.ph'))
    .with headers: default_headers
end
