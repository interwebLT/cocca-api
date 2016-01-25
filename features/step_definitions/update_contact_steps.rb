When /^I update a contact$/ do
  client.expect :update, 'contact/patch_response'.epp, [EPP::Contact::Update]

  EPP::Client.stub :new, client do
    patch '/contacts/contact123', 'contact/patch_request'.json
  end
end

When /^I update a contact that does not exist$/ do
  client.expect :update, 'contact/patch_failed_response'.epp, [EPP::Contact::Update]

  EPP::Client.stub :new, client do
    patch '/contacts/doesnotexist', 'contact/patch_request'.json
  end
end

When /^I update a contact with a new handle$/ do
  client.expect :update, 'contact/patch_failed_response'.epp, [EPP::Contact::Update]

  EPP::Client.stub :new, client do
    patch '/contacts/contact123', 'contact/patch_request'.json
  end
end

When /^I update a contact that I do not own$/ do
  client.expect :update, 'contact/patch_failed_response'.epp, [EPP::Contact::Update]

  EPP::Client.stub :new, client do
    patch '/contacts/othercontact', 'contact/patch_request'.json
  end
end

When /^I update a contact and change the handle$/ do
  client.expect :update, 'contact/patch_failed_response'.epp, [EPP::Contact::Update]

  EPP::Client.stub :new, client do
    patch '/contacts/newhandle', 'contact/patch_request'.json
  end
end

Then /^contact must be updated on EPP$/ do
  json_response.must_equal 'contact/patch_response'.json
end
