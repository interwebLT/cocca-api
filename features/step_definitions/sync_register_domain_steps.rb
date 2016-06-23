Given /^I registered a domain$/ do
  FactoryGirl.create :register_domain
end

Given /^I registered a domain from an excluded IP$/ do
  excluded_ip = FactoryGirl.create :excluded_ip

  domain = FactoryGirl.create :register_domain
  domain.master.update! audit_ip: excluded_ip.ip
end

Given /^I registered a domain with period in months$/ do
  FactoryGirl.create :register_domain_in_months
end

Then /^register domain must be synced$/ do
  expect(WebMock).to have_requested(:post, 'http://test.host/orders')
    .with headers: headers, body: 'sync/orders/post_register_domain_request'.json
end

Then /^register domain must not be synced$/ do
  expect(WebMock).not_to have_requested :post, 'http://test.host/orders'
end
