When(/^I register a domain that is still available$/) do
  client.expect :create, 'domain/create_response'.epp, [EPP::Domain::Create]

  EPP::Client.stub :new, client do
    post orders_path, 'domain/create_request'.json
  end
end

Then(/^domain must be registered$/) do
  json_response.must_equal 'domain/create_response'.json
end
