When(/^I update all contact handles of my domain$/) do
  client.expect :update, 'domain/update_response'.epp, [EPP::Domain::Update]

  EPP::Client.stub :new, client do
    patch '/orders/1', 'domain/update_request'.json
  end
end

Then(/^all contact handles of my domain must be updated$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I update the registrant handle of my domain$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the registrant handle of my domain must be updated$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I update the admin handle of my domain$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the admin handle of my domain must be updated$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I update the billing handle of my domain$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the billing handle of my domain must be updated$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I update the tech handle of my domain$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the tech handle of my domain must be updated$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I update a domain that does not exist$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I update an existing domain with blank registrant handle$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^validation error on registrant_handle must be "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I update an existing domain with non\-existing registrant handle$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I update an existing domain with non\-existing admin handle$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^validation error on admin_handle must be "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I update an existing domain with non\-existing billing handle$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^validation error on billing_handle must be "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I update an existing domain with non\-existing tech handle$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^validation error on tech_handle must be "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end