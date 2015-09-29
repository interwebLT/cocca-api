When(/^I create a host entry$/) do
  client.expect :create, 'host/create_response'.epp, [EPP::Host::Create]

  EPP::Client.stub :new, client do
    post hosts_path, 'host/create_request'.json
  end
end

Then(/^host entry must be created$/) do
  client.verify
  json_response.must_equal 'host/create_response'.json
end