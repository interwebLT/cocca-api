When /^I renew a domain that exists$/ do
  client.expect :create, 'order/create_renew_domain_response'.epp, [EPP::Domain::Renew]

  EPP::Client.stub :new, client do
    post orders_path, 'order/create_renew_domain_request'.json
  end
end

When /^I renew a domain that is still available$/ do
  client.expect :create, 'order/create_renew_domain_failed_response'.epp, [EPP::Domain::Renew]

  EPP::Client.stub :new, client do
    post orders_path, 'order/create_renew_domain_request'.json
  end
end

Then /^domain must be renewed$/ do
  json_response.must_equal 'order/create_renew_domain_response'.json
end

When /^I renew a domain with no domain name$/ do
  request = 'order/create_renew_domain_request'.json
  request[:order_details][0][:domain] = ''
  post orders_path, request
end

When /^I renew a domain with no period$/ do
  request = 'order/create_renew_domain_request'.json
  request[:order_details][0][:domain] = 'domainph'
  post orders_path, request
end

When /^I renew a domain with period more than (\d+) years$/ do |period|
  request = 'order/create_renew_domain_request'.json
  request[:order_details][0][:period] = (period.to_i + 1).to_s
  post orders_path, request
end
