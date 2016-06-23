Given /^I removed a domain host entry from an existing domain$/ do
  domain = FactoryGirl.create :register_domain

  FactoryGirl.create :delete_domain_host, audit_transaction: domain.audit_transaction
end

Then /^remove domain host must be synced$/ do
  url = 'http://test.host/domains/domains.ph/hosts/ns5.domains.ph'

  expect(WebMock).to have_requested(:delete, url).with headers: headers
end
