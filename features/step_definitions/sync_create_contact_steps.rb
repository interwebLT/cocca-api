Given /^I created a contact$/ do
  FactoryGirl.create :audit_contact
end

Then /^create contact must be synced$/ do
  expect(WebMock).to have_requested(:post, 'http://test.host/contacts')
    .with headers: headers, body: 'sync/contacts/post_request'.json
end
