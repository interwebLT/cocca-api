When /^I create a new partner$/ do
  post partners_path, 'partner/post_request'.json
end

When /^I create a new partner with empty parameters$/ do
  post partners_path, 'partner/post_with_empty_parameters_request'.json
end

When /^I create a new partner with no name$/ do
  post partners_path, 'partner/post_with_no_name_request'.json
end

When /^I create a new partner with no password$/ do
  post partners_path, 'partner/post_with_no_password_request'.json
end

Then /^partner must be created$/ do
  expect(last_response.status).to eql 201

  expect(Partner.exists?(name: 'alpha')).to be true
end
