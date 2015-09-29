When(/^I create a host entry$/) do
  client.expect :create, 'host/create_response'.epp, [EPP::Host::Create]

  EPP::Client.stub :new, client do
    post hosts_path, 'host/create_request'.json
  end
end

When(/^I create a host entry with no host name$/) do
  request = "host/create_request_no_hostname".json
  post hosts_path, request
end

When(/^I create a host entry with blank host name$/) do
  request = "host/create_request_blank_hostname".json
  post hosts_path, request
end

When(/^I create a host entry with existing host name$/) do
  client.expect :create, 'host/epp_failure'.epp, [EPP::Host::Create]

  EPP::Client.stub :new, client do
    post hosts_path, 'host/create_request'.json
  end
end

Then(/^host entry must be created$/) do
  client.verify
  json_response.must_equal 'host/create_response'.json
end

