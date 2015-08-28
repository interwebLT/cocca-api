When  /^I create a new contact with required fields only$/ do
  params = {
    name: 'Name',
    city: 'City',
    country_code: 'PH',
    email:  'contact@test.ph'
  }

  post contacts_path, params
end

Then  /^contact must be created$/ do
  json_response = JSON.parse last_response.body, symbolize_names: true

  expected_response = {
    name: 'Name',
    organization: nil,
    street: nil,
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
    local_city: 'City',
    local_state:  nil,
    local_postal_code:  nil,
    local_country_code: nil,
    voice:  nil,
    voice_ext:  nil,
    fax:  nil,
    fax_ext:  nil,
    email:  'contact@test.ph'
  }

  json_response.must_equal expected_response
end
