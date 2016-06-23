Given /^I added a domain host entry to an existing domain$/ do
  domain = FactoryGirl.create :register_domain

  FactoryGirl.create :create_domain_host, audit_transaction: domain.audit_transaction
end

Then /^add domain host must be synced$/ do
  expect(WebMock).to have_requested(:post, 'http://test.host/domains/domains.ph/hosts')
    .with headers: headers, body: 'sync/domains/domains.ph/hosts/post_request'.json
end
