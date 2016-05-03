When /^I update a contact$/ do
  client.expect :update, 'contacts/update_response'.epp, [EPP::Contact::Update]

  EPP::Client.stub :new, client do
    patch '/contacts/contact123', 'contacts/patch_request'.json
  end
end

When /^I update a contact that does not exist$/ do
  client.expect :update, 'contacts/update_failed_response'.epp, [EPP::Contact::Update]

  EPP::Client.stub :new, client do
    patch '/contacts/doesnotexist', 'contacts/patch_request'.json
  end
end

When /^I update a contact with a new handle$/ do
  client.expect :update, 'contacts/update_failed_response'.epp, [EPP::Contact::Update]

  EPP::Client.stub :new, client do
    patch '/contacts/contact123', 'contacts/patch_request'.json
  end
end

When /^I update a contact that I do not own$/ do
  client.expect :update, 'contacts/update_failed_response'.epp, [EPP::Contact::Update]

  EPP::Client.stub :new, client do
    patch '/contacts/othercontact', 'contacts/patch_request'.json
  end
end

When /^I update a contact and change the handle$/ do
  client.expect :update, 'contacts/update_failed_response'.epp, [EPP::Contact::Update]

  EPP::Client.stub :new, client do
    patch '/contacts/newhandle', 'contacts/patch_request'.json
  end
end

Then /^contact must be updated on EPP$/ do
  expect(json_response).to eql 'contacts/patch_response'.json
end
