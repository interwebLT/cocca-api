FactoryGirl.define do
  factory :contact do
    handle 'contact123'
    name 'Contact'
    partner 'alpha'
    street  'Street'
    city  'City'
    country_code  'PH'
    voice '+63.1234567'
    email 'contact@test.ph'
    authcode  'ABC123'

    factory :complete_contact do
      organization  'Organization'
      street2 'Street 2'
      street3 'Street 3'
      state 'State'
      postal_code 1234
      local_name  'Local Contact'
      local_organization  'Local Organization'
      local_street  'Local Street'
      local_street2 'Local Street 2'
      local_street3 'Local Street 3'
      local_city  'Local City'
      local_state 'Local State'
      local_postal_code 1235
      local_country_code  'RP'
      voice_ext 1234
      fax '+63.1234568'
      fax_ext 1235
    end
  end
end
