When(/^I register a domain that is still available$/) do
  client.expect :create, 'domain/create_response'.epp, [EPP::Domain::Create]

  EPP::Client.stub :new, client do
    post orders_path, 'domain/create_request'.json
  end
end

When(/^I register multiple domains that are still available$/) do
  client.expect :create, 'domain/create_response'.epp, [EPP::Domain::Create]
  client.expect :create, 'domain/create_response'.epp, [EPP::Domain::Create]

  EPP::Client.stub :new, client do
    post orders_path, 'domain/create_multiple_domains_request'.json
  end
end

When(/^I place an order that fails at an external step$/) do
  client.expect :create, 'domain/create_response'.epp, [EPP::Domain::Create]
  client.expect :create, 'domain/create_response_failed'.epp, [EPP::Domain::Create]
  client.expect :create, 'domain/create_response'.epp, [EPP::Domain::Create]

  EPP::Client.stub :new, client do
    post orders_path, 'domain/create_multiple_domains_request'.json
  end
end

When(/^I register multiple domains with one validation error$/) do
  request = 'domain/create_multiple_domains_one_error'.json
  post orders_path, request
end

Then(/^domains must be registered$/) do
  client.verify
  json_response.must_equal 'domain/create_multiple_domains_response'.json
end

Then(/^domain must be registered$/) do
  json_response.must_equal 'domain/create_response'.json
end

When(/^I register a domain using (.*)$/) do |type|
  table = {
    "no domain name" => "no_domain",
    "no period" => "no_period",
    "period more than 10 years" => "large_period",
    "no registrant handle" => "no_registrant",
    "no authcode" => "no_authcode",
    "missing order details" => 'missing_order_details'
  }

  suffix = table[type]

  request = "domain/create_request_#{suffix}".json
  post orders_path, request
end

When(/^I register a domain with existing domain name$/) do
  client.expect :create, 'domain/create_response_failed'.epp, [EPP::Domain::Create]

  EPP::Client.stub :new, client do
    post orders_path, 'domain/create_request'.json
  end
end

When(/^I register a domain with non\-existing registrant handle$/) do
  client.expect :create, 'domain/create_response_failed'.epp, [EPP::Domain::Create]

  EPP::Client.stub :new, client do
    post orders_path, 'domain/create_request'.json
  end
end