When /^I try to view the info of an existing host$/ do
  client = double 'client'

  expect(client).to receive(:check).and_return 'hosts/ns5.domains.ph/check_response'.epp
  expect(EPP::Client).to receive(:new) { client }

  get host_path('ns5.domains.ph')
end

When /^I try to view the info of a host that does not exist$/ do
  client = double 'client'

  expect(client).to receive(:check).and_return 'hosts/dne.domains.ph/check_response'.epp
  expect(EPP::Client).to receive(:new) { client }

  get host_path('dne.domains.ph')
end

Then /^I must see the info of the host$/ do
  expect(last_response).to have_attributes status: 200
  expect(json_response).to eq 'hosts/ns5.domains.ph/get_response'.json
end

Then /^I must be notified that host does not exist$/ do
  expect(last_response).to have_attributes status: 404
  expect(json_response).to eq 'common/404'.json
end
