Given /^registry accepts sync requests$/ do
  stub_request(:post, 'http://test.host/orders')
    .to_return status: 201, body: { id: 1 }.to_json

  stub_request(:post, 'http://test.host/contacts')
    .to_return status: 201, body: { id: 1 }.to_json

  stub_request(:post, 'http://test.host/hosts')
    .to_return status: 201, body: { id: 1 }.to_json

  stub_request(:post, 'http://test.host/hosts/ns5.domains.ph/addresses')
    .to_return status: 201, body: { id: 1 }.to_json

  stub_request(:post, 'http://test.host/domains/domains.ph/hosts')
    .to_return status: 201, body: { id: 1 }.to_json

  stub_request(:patch, 'http://test.host/contacts/handle')
    .to_return status: 200, body: { id: 1 }.to_json

  stub_request(:patch, 'http://test.host/domains/domains.ph')
    .to_return status: 200, body: { id: 1 }.to_json

  stub_request(:delete, 'http://test.host/domains/domains.ph')
    .to_return status: 200, body: { id: 1 }.to_json

  stub_request(:delete, 'http://test.host/domains/domains.ph/hosts/ns5.domains.ph')
    .to_return status: 200, body: { id: 1 }.to_json

  stub_request(:delete, 'http://test.host/hosts/ns5.domains.ph/addresses/123.123.123.001')
    .to_return status: 200, body: { id: 1 }.to_json
end

Given /^some partners are excluded from sync$/ do
  FactoryGirl.create :excluded_partner
  FactoryGirl.create :excluded_partner, name: 'other_excluded'
end

Given /^I am allowed to sync to registry$/ do
  FactoryGirl.create :partner
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

Given /^I renewed a domain with period in months$/ do
  FactoryGirl.create :renew_domain_in_months
end

Given /^I transferred a domain into my partner account$/ do
  FactoryGirl.create :transfer_domain
end

Given /^I deleted an existing domain$/ do
  FactoryGirl.create :delete_domain
end

When /^latest changes are synced$/ do
  SyncLog.create  since: '2015-01-01 00:00'.in_time_zone,
                  until: '2015-01-01 00:00'.in_time_zone

  Sync.run
end

When /^syncing of latest changes results in an error$/ do
  stub_request(:post, 'http://test.host/orders')
    .to_return status: 400, body: { id: 1 }.to_json

  SyncLog.create  since: '2015-01-01 00:00'.in_time_zone,
                  until: '2015-01-01 00:00'.in_time_zone
end

Then /^domain must be updated$/ do
  expect(WebMock).to have_requested(:patch, 'http://test.host/domains/domains.ph')
    .with headers: headers, body: 'sync/domains/patch_request'.json
end

Then /^domain contact must be updated$/ do
  expect(WebMock).to have_requested(:patch, 'http://test.host/domains/domains.ph')
    .with headers: headers, body: 'sync/domains/patch_admin_handle_request'.json
end

Then /^I must be informed of the error$/ do
  expect { Sync.run }.to raise_error Exception
end

Then /^domain must now be renewed$/ do
  expect(WebMock).to have_requested(:post, 'http://test.host/orders')
    .with headers: headers, body: 'sync/orders/post_renew_domain_request'.json
end

Then /^domain must now be under my partner$/ do
  expect(WebMock).to have_requested(:post, 'http://test.host/orders')
    .with headers: headers, body: 'sync/orders/post_transfer_domain_request'.json
end

Then /^no changes must be synced$/ do
  expect(WebMock).not_to have_requested :post, 'http://test.host/orders'
end

Then /^domain must now be deleted$/ do
  expect(WebMock).to have_requested(:delete, 'http://test.host/domains/domains.ph')
    .with headers: headers
end
