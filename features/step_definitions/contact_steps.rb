When /^I create a new contact with required fields only$/ do
  client.expect :create, 'contacts/post_response'.epp, [EPP::Contact::Create]

  EPP::Client.stub :new, client do
    post contacts_path, 'contacts/post_request'.json
  end
end

When /^I create a new contact with complete fields provided$/ do
  client.expect :create, 'contacts/post_response'.epp, [EPP::Contact::Create]

  EPP::Client.stub :new, client do
    post contacts_path, 'contacts/post_request_complete'.json
  end
end

When /^I create a new contact with missing (.*?)$/ do |field|
  post contacts_path, 'contacts/post_request'.json.delete(field.to_sym)
end

When /^I create a new contact with an existing handle$/ do
  client.expect :create, 'contacts/post_response_failed'.epp, [EPP::Contact::Create]

  EPP::Client.stub :new, client do
    post contacts_path, 'contacts/post_request'.json
  end
end

Then /^contact must be created$/ do
  expect(json_response).to eql 'contacts/post_response'.json
end

Then /^complete contact must be created$/ do
  expect(json_response).to eql 'contacts/post_response_complete'.json
end
