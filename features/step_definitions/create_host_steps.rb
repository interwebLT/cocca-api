When /^I create a host entry$/ do
  client.expect :create, 'hosts/create_response'.epp, [EPP::Host::Create]

  EPP::Client.stub :new, client do
    post hosts_path, 'hosts/create_request'.json
  end
end

When /^I create a host entry with no host name$/ do
  post hosts_path, 'hosts/create_request_no_hostname'.json
end

When /^I create a host entry with blank host name$/ do
  post hosts_path, 'hosts/create_request_blank_hostname'.json
end

When /^I create a host entry with existing host name$/ do
  client.expect :create, 'hosts/epp_failure'.epp, [EPP::Host::Create]

  EPP::Client.stub :new, client do
    post hosts_path, 'hosts/create_request'.json
  end
end

Then /^host entry must be created$/ do
  client.verify

  expect(json_response).to eql 'hosts/create_response'.json
end

