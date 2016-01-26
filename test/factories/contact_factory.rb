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
    organization nil
    street2  nil
    street3  nil
    state  nil
    postal_code  nil
    local_name nil
    local_organization nil
    local_street nil
    local_street2  nil
    local_street3  nil
    local_city nil
    local_state  nil
    local_postal_code  nil
    local_country_code nil
    voice_ext  nil
    fax  nil
    fax_ext  nil
  end
end
