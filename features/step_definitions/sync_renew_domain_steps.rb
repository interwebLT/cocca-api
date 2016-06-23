Given /^I renewed a domain$/ do
  FactoryGirl.create :renew_domain
end

Given /^I renewed a domain with period in months$/ do
  FactoryGirl.create :renew_domain_in_months
end

Then /^renew domain must be synced$/ do
  expect(WebMock).to have_requested(:post, 'http://test.host/orders')
    .with headers: headers, body: 'sync/orders/post_renew_domain_request'.json
end
