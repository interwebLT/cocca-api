Given /^I am authenticated as partner$/ do
  create :partner
end

Then  /^error must be validation failed$/ do
  last_response.status.must_equal 422
end
