Given /^I am authenticated as partner$/ do
  partner = create :partner

  header  'Authorization',
          ActionController::HttpAuthentication::Token.encode_credentials(partner.name)
end

Then /^error must be validation failed$/ do
  last_response.status.must_equal 422
end

Then /^error must be not found$/ do
  last_response.status.must_equal 422
end

Then /^error must be bad request$/ do
  last_response.status.must_equal 422
end
