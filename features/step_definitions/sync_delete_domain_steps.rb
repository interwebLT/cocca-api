Given /^I deleted an existing domain$/ do
  FactoryGirl.create :delete_domain
end

Then /^delete domain must be synced$/ do
  expect(WebMock).to have_requested(:delete, 'http://test.host/domains/domains.ph')
    .with headers: headers
end
