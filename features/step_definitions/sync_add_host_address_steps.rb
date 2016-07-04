Given /^I added a host address to an existing host$/ do
  FactoryGirl.create :create_host_address
end

Then /^add host address must be synced$/ do
  expect(WebMock).to have_requested(:post, 'http://test.host/hosts/ns5.domains.ph/addresses')
    .with headers: headers, body: 'sync/hosts/ns5.domains.ph/addresses/post_request'.json
end
