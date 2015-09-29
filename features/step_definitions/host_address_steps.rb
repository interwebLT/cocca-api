Before do
  Time.zone = "UTC"

  t = Time.zone.local(2015, 1, 1, 0, 0, 0)
  Timecop.freeze(t)
end

When(/^I add an ipv4 host address entry to an existing host$/) do
  client.expect :update, 'host/add_ipv4_response'.epp, [EPP::Host::Update]

  EPP::Client.stub :new, client do
    post host_addresses_path('domain.ph'), 'host/add_ipv4_request'.json
  end
end

Then(/^host address must be created$/) do
  client.verify
  json_response.must_equal 'host/add_ipv4_response'.json
end