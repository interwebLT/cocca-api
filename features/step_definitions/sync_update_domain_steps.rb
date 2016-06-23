Given /^I updated an existing domain$/ do
  FactoryGirl.create :update_domain
end

Given /^I updated a contact of an existing domain$/ do
  domain = FactoryGirl.create :update_domain

  FactoryGirl.create :admin_domain_contact, audit_transaction: domain.audit_transaction
end

Then /^update domain must be synced$/ do
  expect(WebMock).to have_requested(:patch, 'http://test.host/domains/domains.ph')
    .with headers: headers, body: 'sync/domains/patch_request'.json
end

Then /^update domain contact must be synced$/ do
  expect(WebMock).to have_requested(:patch, 'http://test.host/domains/domains.ph')
    .with headers: headers, body: 'sync/domains/patch_admin_handle_request'.json
end
