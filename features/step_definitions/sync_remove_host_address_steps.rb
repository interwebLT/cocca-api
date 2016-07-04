Given /^I removed a host address from an existing host$/ do
  FactoryGirl.create :delete_host_address
end

Then /^remove host address must be synced$/ do
  url = 'http://test.host/hosts/ns5.domains.ph/addresses/123.123.123.001'

  expect(WebMock).to have_requested(:delete, url).with headers: headers
end
