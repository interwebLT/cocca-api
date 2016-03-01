Given /^I am authenticated as partner$/ do
  partner = create :partner

  header  'Authorization',
          ActionController::HttpAuthentication::Token.encode_credentials(partner.name)
end

Then /^error must be validation failed$/ do
  expect(last_response.status).to eql 422
end

Then /^error must be not found$/ do
  expect(last_response.status).to eql 422
end

Then /^error must be bad request$/ do
  expect(last_response.status).to eql 422
end
