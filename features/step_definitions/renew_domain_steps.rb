When(/^I renew a domain that exists$/) do
  client.expect :create, 'domain/renew_response'.epp, [EPP::Domain::Renew]

  EPP::Client.stub :new, client do
    post orders_path, 'domain/renew_request'.json
  end
end

Then(/^domain must be renewed$/) do
  json_response.must_equal 'domain/renew_response'.json
end
