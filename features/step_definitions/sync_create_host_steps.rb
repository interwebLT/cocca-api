Given /^I created a host entry$/ do
  FactoryGirl.create :audit_host
end

Then /^create host must be synced$/ do
  expect(WebMock).to have_requested(:post, 'http://test.host/hosts')
    .with headers: headers, body: 'sync/hosts/post_request'.json
end
