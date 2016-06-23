When /^I add an ipv4 host address entry to an existing host$/ do
  Time.zone = "UTC"

  t = Time.zone.local(2015, 1, 1, 0, 0, 0)
  Timecop.freeze(t)

  client.expect :update, 'hosts/add_host_address_response'.epp do |command|
    expect(command.as_json['name']).to eql 'domain.ph'
    expect(command.as_json['add']['addr']['ipv4']).to eql '255.255.255.255'
  end

  EPP::Client.stub :new, client do
    post host_addresses_path('domain.ph'), 'hosts/add_ipv4_request'.json
  end

  Timecop.return
end

When /^I add an ipv6 host address entry to an existing host$/ do
  Time.zone = "UTC"

  t = Time.zone.local(2015, 1, 1, 0, 0, 0)
  Timecop.freeze(t)

  client.expect :update, 'hosts/add_host_address_response'.epp do |command|
    expect(command.as_json['name']).to eql 'domain.ph'
    expect(command.as_json['add']['addr']['ipv6']).to eql 'FE80:0000:0000:0000:0202:B3FF:FE1E:8329'
  end

  EPP::Client.stub :new, client do
    post host_addresses_path('domain.ph'), 'hosts/add_ipv6_request'.json
  end

  Timecop.return
end

When /^I add a host address entry using (.*)$/ do | type |
  table = {
    "blank address" => "blank_address",
    "missing address" => "missing_address",
    "blank type" => "blank_type",
    "missing type" => "missing_type",
    "invalid type" => "invalid_type"
  }

  suffix = table[type]

  request = "hosts/add_ipv4_#{suffix}".json
  post host_addresses_path('domain.ph'), request
end

When /^I add a host address entry which is already present$/ do
  client.expect :update, 'hosts/epp_failure'.epp, [EPP::Host::Update]

  EPP::Client.stub :new, client do
    post host_addresses_path('domain.ph'), 'hosts/add_ipv4_request'.json
  end
end

When /^I add a host address entry for non\-existing host$/ do
  client.expect :update, 'hosts/epp_failure'.epp, [EPP::Host::Update]

  EPP::Client.stub :new, client do
    post host_addresses_path('domain.ph'), 'hosts/add_ipv4_request'.json
  end
end

Then /^ipv4 host address must be created$/ do
  client.verify

  expect(json_response).to eql 'hosts/add_ipv4_response'.json
end

Then /^ipv6 host address must be created$/ do
  client.verify

  expect(json_response).to eql 'hosts/add_ipv6_response'.json
end
