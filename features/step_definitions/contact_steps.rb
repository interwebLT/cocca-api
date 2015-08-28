When  /^I create a new contact with required fields only$/ do
  xml = '''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
  <response>
    <result code="1000">
      <msg>Command completed successfully</msg>
    </result>
    <resData>
      <contact:creData xmlns:contact="urn:ietf:params:xml:ns:contact-1.0">
        <contact:id>contact123</contact:id>
        <contact:crDate>1999-04-03T22:00:00.0Z</contact:crDate>
      </contact:creData>
    </resData>
    <trID>
      <clTRID>ABC-12345</clTRID>
      <svTRID>54321-XYZ</svTRID>
    </trID>
  </response>
</epp>
  '''.strip

  client = Minitest::Mock.new
  client.expect :create, EPP::Response.new(xml), [EPP::Contact::Create]

  params = {
    handle: 'contact123',
    name: 'Name',
    city: 'City',
    country_code: 'PH',
    email:  'contact@test.ph'
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
