When /^I try to view the info of an existing contact$/ do
  client = double 'client'

  expect(client).to receive(:check).and_return 'contacts/123456789ABCDEF/check_response'.epp
  expect(EPP::Client).to receive(:new) { client }

  get contact_path('123456789ABCDEF')
end

When /^I try to view the info of contact that does not exist$/ do
  client = double 'client'

  expect(client).to receive(:check).and_return 'contacts/doesnotexist/check_response'.epp
  expect(EPP::Client).to receive(:new) { client }

  get contact_path('doesnotexist')
end

Then /^I must see the info of the contact$/ do
  expect(last_response).to have_attributes status: 200
  expect(json_response).to eq 'contacts/123456789ABCDEF/get_response'.json
end

Then /^I must be notified that contact does not exist$/ do
  expect(last_response).to have_attributes status: 404
  expect(json_response).to eq 'common/404'.json
end
