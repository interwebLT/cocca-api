When /^I create a new partner$/ do
  post partners_path, 'partner/create_request'.json
end

Then /^partner must be created$/ do
  last_response.status.must_equal 201

  Partner.exists?(name: 'alpha').must_equal true
end
