When  /^I create a new contact with required fields only$/ do
  client.expect :create, 'contact/create_response'.epp, [EPP::Contact::Create]

  EPP::Client.stub :new, client do
    post contacts_path, 'contact/create_request'.json
  end
end

When  /^I create a new contact with missing handle$/ do
  client.expect :create, 'contact/create_response_failed'.epp, [EPP::Contact::Create]

  EPP::Client.stub :new, client do
    post contacts_path, 'contact/create_request'.json.delete(:handle)
  end
end

Then  /^contact must be created$/ do
  json_response.must_equal 'contact/create_response'.json
end

Then  /^error must be validation failed$/ do
  last_response.status.must_equal 400
end
