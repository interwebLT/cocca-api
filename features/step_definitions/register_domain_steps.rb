When /^I register a domain that is still available$/ do
  client.expect :create, 'orders/post_register_domain_response'.epp, [EPP::Domain::Create]

  EPP::Client.stub :new, client do
    post orders_path, 'orders/post_register_domain_request'.json
  end
end

When /^I register multiple domains that are still available$/ do
  client.expect :create, 'orders/post_register_domain_response'.epp, [EPP::Domain::Create]
  client.expect :create, 'orders/post_register_domain_response'.epp, [EPP::Domain::Create]

  EPP::Client.stub :new, client do
    post orders_path, 'orders/post_multiple_register_domain_request'.json
  end
end

When /^I register multiple domains with one validation error$/ do
  post orders_path, 'orders/post_multiple_register_domain_with_one_error_request'.json
end

When /^I place an order that fails at an external step$/ do
  client.expect :create, 'orders/post_register_domain_response'.epp, [EPP::Domain::Create]
  client.expect :create, 'orders/post_register_domain_failed_response'.epp, [EPP::Domain::Create]
  client.expect :create, 'orders/post_register_domain_response'.epp, [EPP::Domain::Create]

  EPP::Client.stub :new, client do
    post orders_path, 'orders/post_multiple_register_domain_request'.json
  end
end

When /^I register a domain using (.*)$/ do |scenario|
  scenarios = {
    "no domain name"  => "no_domain",
    "no period" => "no_period",
    "period more than 10 years" => "period_more_than_ten_years",
    "no registrant handle"  => "no_registrant",
    "no authcode" => "no_authcode",
    "missing order details" => 'no_order_details'
  }

  post orders_path, "orders/post_register_domain_with_#{scenarios[scenario]}_request".json
end

When /^I register a domain with existing domain name$/ do
  client.expect :create, 'orders/post_register_domain_failed_response'.epp, [EPP::Domain::Create]

  EPP::Client.stub :new, client do
    post orders_path, 'orders/post_register_domain_with_existing_domain_request'.json
  end
end

When /^I register a domain with non\-existing registrant handle$/ do
  client.expect :create, 'orders/post_register_domain_failed_response'.epp, [EPP::Domain::Create]

  EPP::Client.stub :new, client do
    post orders_path, 'orders/post_register_domain_with_non_existing_registrant_handle_request'.json
  end
end

Then /^domains must be registered$/ do
  client.verify

  expect(json_response).to eql 'orders/post_multiple_register_domain_response'.json
end

Then /^domain must be registered$/ do
  expect(json_response).to eql 'orders/post_register_domain_response'.json
end
