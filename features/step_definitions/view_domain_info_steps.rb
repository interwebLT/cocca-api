When /^I try to view the info of an existing domain$/ do
  client = double 'client'

  expect(client).to receive(:check).and_return 'domains/domain.ph/check_response'.epp
  expect(EPP::Client).to receive(:new) { client }

  get domain_path('domain.ph')
end

When /^I try to view the info of an available domain$/ do
  client = double 'client'

  expect(client).to receive(:check).and_return 'domains/available.ph/check_response'.epp
  expect(EPP::Client).to receive(:new) { client }

  get domain_path('available.ph')
end

Then /^I must see the info of the domain$/ do
  expect(last_response).to have_attributes status: 200
  expect(json_response).to eq 'domains/domain.ph/get_response'.json
end

Then /^I must be notified that domain is available$/ do
  expect(last_response).to have_attributes status: 404
  expect(json_response).to eq 'common/404'.json
end
