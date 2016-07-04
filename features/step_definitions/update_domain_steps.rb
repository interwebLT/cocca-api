When /^I update all contact handles of my domain$/ do
  client.expect :update, 'domains/update_response'.epp, [EPP::Domain::Update]

  EPP::Client.stub :new, client do
    patch '/orders/1', 'domains/update_request'.json
  end
end

When /^I update the authcode of my domain$/ do
  client.expect :update, 'domains/update_authcode_response'.epp, [EPP::Domain::Update]

  EPP::Client.stub :new, client do
    patch '/domains/test.ph', 'domains/update_authcode'.json
  end
end

When /^I update the authcode of a domain that does not exist$/ do
  client.expect :update, 'domains/update_authcode_response_failed'.epp, [EPP::Domain::Update]

  EPP::Client.stub :new, client do
    patch '/domains/test.ph', 'domains/update_authcode'.json
  end
end

Then /^authcode must be updated$/ do
  expect(last_response.status).to eql 200
end
