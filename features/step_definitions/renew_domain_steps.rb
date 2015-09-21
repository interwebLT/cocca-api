When(/^I renew a domain that exists$/) do
  client.expect :create, 'domain/renew_response'.epp, [EPP::Domain::Renew]

  EPP::Client.stub :new, client do
    post orders_path, 'domain/renew_request'.json
  end
end

When(/^I renew a domain that is still available$/) do
  client.expect :create, 'domain/renew_response_failed'.epp, [EPP::Domain::Renew]

  EPP::Client.stub :new, client do
    post orders_path, 'domain/renew_request'.json
  end
end


Then(/^domain must be renewed$/) do
  json_response.must_equal 'domain/renew_response'.json
end

When(/^I renew a domain with no domain name$/) do
  request = 'domain/renew_request'.json
  request[:order_details][0][:domain] = ''
  post orders_path, request
end

When(/^I renew a domain with no period$/) do
  request = 'domain/renew_request'.json
  request[:order_details][0][:domain] = 'domainph'
  post orders_path, request
end

When(/^I renew a domain with period more than (\d+) years$/) do |period|
  request = 'domain/renew_request'.json
  request[:order_details][0][:period] = (period.to_i + 1).to_s
  post orders_path, request
end