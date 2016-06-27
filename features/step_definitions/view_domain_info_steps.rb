When /^I try to view the info of an existing domain$/ do
  get domain_path('test.ph')
end

Then /^I must see the info of the domain$/ do
  expect(last_response).to have_attributes status: 200
  expect(json_response).to eq 'domains/test.ph/get_response'.json
end
