When  /^I create a new contact with required fields only$/ do
  client = Minitest::Mock.new
  client.expect :create, 'contact/create_response'.epp, [EPP::Contact::Create]

  params = {
    handle: 'contact123',
    name: 'Name',
    street: 'Street',
    city: 'City',
    country_code: 'PH',
    voice:  '+63.1234567',
    email:  'contact@test.ph',
    authcode: 'ABC123'
  }

  EPP::Client.stub :new, client do
    post contacts_path, params
  end
end

When  /^I create a new contact with missing handle$/ do
  client = Minitest::Mock.new
  client.expect :create, 'contact/create_response_failed'.epp, [EPP::Contact::Create]

  params = {
    name: 'Name',
    street: 'Street',
    city: 'City',
    country_code: 'PH',
    voice:  '+63.1234567',
    email:  'contact@test.ph',
    authcode: 'ABC123'
  }

  EPP::Client.stub :new, client do
    post contacts_path, params
  end
end

Then  /^contact must be created$/ do
  json_response = JSON.parse last_response.body, symbolize_names: true

  expected_response = {
    handle: 'contact123',
    name: 'Name',
    organization: nil,
    street: 'Street',
    street2:  nil,
    street3:  nil,
    city: 'City',
    state:  nil,
    postal_code:  nil,
    country_code: 'PH',
    local_name: nil,
    local_organization: nil,
    local_street: nil,
    local_street2:  nil,
    local_street3:  nil,
    local_city: nil,
    local_state:  nil,
    local_postal_code:  nil,
    local_country_code: nil,
    voice:  '+63.1234567',
    voice_ext:  nil,
    fax:  nil,
    fax_ext:  nil,
    email:  'contact@test.ph'
  }

  json_response.must_equal expected_response
end

Then  /^error must be validation failed$/ do
  last_response.status.must_equal 400
end
