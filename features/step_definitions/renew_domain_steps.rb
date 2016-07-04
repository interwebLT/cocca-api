When /^I renew a domain that exists$/ do
  client.expect :renew, 'orders/post_renew_domain_response'.epp, [EPP::Domain::Renew]

  EPP::Client.stub :new, client do
    post orders_path, 'orders/post_renew_domain_request'.json
  end
end

When /^I renew a domain that is still available$/ do
  client.expect :renew, 'orders/post_renew_domain_failed_response'.epp, [EPP::Domain::Renew]

  EPP::Client.stub :new, client do
    post orders_path, 'orders/post_renew_domain_request'.json
  end
end

When /^I renew a domain with no domain name$/ do
  post orders_path, 'orders/post_renew_domain_with_no_domain_name_request'.json
end

When /^I renew a domain with no period$/ do
  post orders_path, 'orders/post_renew_domain_with_no_period_request'.json
end

When /^I renew a domain with period more than 10 years$/ do
  post orders_path, 'orders/post_renew_domain_with_period_more_than_ten_years_request'.json
end

When /^I renew a domain with no current expires at$/ do
  post orders_path, 'orders/post_renew_domain_with_no_current_expires_at_request'.json
end

Then /^domain must be renewed$/ do
  expect(json_response).to eql 'orders/post_renew_domain_response'.json
end
