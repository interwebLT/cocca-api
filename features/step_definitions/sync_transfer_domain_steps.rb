Given /^I transferred a domain into my partner account$/ do
  FactoryGirl.create :transfer_domain
end

Then /^transfer domain must be synced$/ do
  expect(WebMock).to have_requested(:post, 'http://test.host/orders')
    .with headers: headers, body: 'sync/orders/post_transfer_domain_request'.json
end
