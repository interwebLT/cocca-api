Given /^I updated an existing contact$/ do
  FactoryGirl.create :update_contact
end

Then /^update contact must be synced$/ do
  expect(WebMock).to have_requested(:patch, 'http://test.host/contacts/handle')
    .with headers: headers, body: 'sync/contacts/patch_request'.json
end
