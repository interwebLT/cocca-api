When /^I try to remove a domain host from a domain$/ do
  delete domain_host_path('domain.ph', 'ns5.domains.ph')
end

Then /^domain must no longer have domain host$/ do
  expect(json_response).to eql 'domains/domain.ph/hosts/ns5.domains.ph/delete_response'.json
end
