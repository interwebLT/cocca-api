When(/^I add an ipv4 host address entry to an existing host$/) do
  Time.zone = "UTC"

  t = Time.zone.local(2015, 1, 1, 0, 0, 0)
  Timecop.freeze(t)

  client.expect :update, 'host/add_host_address_response'.epp do |command|
    command.as_json['name'].must_equal 'domain.ph'
    command.as_json['add']['addr']['ipv4'].must_equal '255.255.255.255'
  end 

  EPP::Client.stub :new, client do
    post host_addresses_path('domain.ph'), 'host/add_ipv4_request'.json
  end

  Timecop.return
end

When(/^I add an ipv6 host address entry to an existing host$/) do
  Time.zone = "UTC"

  t = Time.zone.local(2015, 1, 1, 0, 0, 0)
  Timecop.freeze(t)

  client.expect :update, 'host/add_host_address_response'.epp do |command|
    command.as_json['name'].must_equal 'domain.ph'
    command.as_json['add']['addr']['ipv6'].must_equal 'FE80:0000:0000:0000:0202:B3FF:FE1E:8329'
  end 

  EPP::Client.stub :new, client do
    post host_addresses_path('domain.ph'), 'host/add_ipv6_request'.json
  end

  Timecop.return
end

Then(/^ipv4 host address must be created$/) do
  client.verify
  json_response.must_equal 'host/add_ipv4_response'.json
end

Then(/^ipv6 host address must be created$/) do
  client.verify
  json_response.must_equal 'host/add_ipv6_response'.json
end

When(/^I add a host address entry using (.*)$/) do | type |
  table = {
    "blank address" => "blank_address",
    "missing address" => "missing_address",
    "blank type" => "blank_type",
    "missing type" => "missing_type",
    "invalid type" => "invalid_type"
  }

  suffix = table[type]

  request = "host/add_ipv4_#{suffix}".json
  post host_addresses_path('domain.ph'), request
end

When(/^I add a host address entry which is already present$/) do
  client.expect :update, 'host/epp_failure'.epp, [EPP::Host::Update]

  EPP::Client.stub :new, client do
    post host_addresses_path('domain.ph'), 'host/add_ipv4_request'.json
  end
end

When(/^I add a host address entry for non\-existing host$/) do
  client.expect :update, 'host/epp_failure'.epp, [EPP::Host::Update]

  EPP::Client.stub :new, client do
    post host_addresses_path('domain.ph'), 'host/add_ipv4_request'.json
  end
end