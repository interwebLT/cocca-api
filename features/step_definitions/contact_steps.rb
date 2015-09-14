When  /^I create a new contact with required fields only$/ do
  client.expect :create, 'contact/create_response'.epp, [EPP::Contact::Create]

  EPP::Client.stub :new, client do
    post contacts_path, 'contact/create_request'.json
  end
end

When  /^I create a new contact with complete fields provided$/ do
  client.expect :create, 'contact/create_response'.epp, [EPP::Contact::Create]

  EPP::Client.stub :new, client do
    post contacts_path, 'contact/create_request_complete'.json
  end
end

When  /^I create a new contact with missing (.*?)$/ do |field|
  post contacts_path, 'contact/create_request'.json.delete(field.to_sym)
end

When  /^I create a new contact with an existing handle$/ do
  client.expect :create, 'contact/create_response_failed'.epp, [EPP::Contact::Create]

  EPP::Client.stub :new, client do
    post contacts_path, 'contact/create_request'.json
  end
end

Then  /^contact must be created$/ do
  json_response.must_equal 'contact/create_response'.json
end

Then  /^complete contact must be created$/ do
  json_response.must_equal 'contact/create_response_complete'.json
end
