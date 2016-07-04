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

Then /^I must be informed of the error$/ do
  expect { Sync.run }.to raise_error Exception
end
