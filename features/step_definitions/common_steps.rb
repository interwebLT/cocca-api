Then  /^error must be validation failed$/ do
  last_response.status.must_equal 400
end
