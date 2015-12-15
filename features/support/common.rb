AUTHORIZATIONS_PATH = /#{Rails.configuration.x.registry_url}\/authorizations/
ORDERS_PATH         = /#{Rails.configuration.x.registry_url}\/orders/
CONTACTS_PATH       = /#{Rails.configuration.x.registry_url}\/contacts/
HOSTS_PATH          = /#{Rails.configuration.x.registry_url}\/hosts/
HOST_ADDRESS_PATH   = /#{Rails.configuration.x.registry_url}\/hosts\/.*\/addresses/
DOMAIN_PATH         = /#{Rails.configuration.x.registry_url}\/domains\/.*/
DOMAIN_HOST_PATH    = /#{Rails.configuration.x.registry_url}\/domains\/.*\/hosts/
CONTACT_PATH        = /#{Rails.configuration.x.registry_url}\/contacts\/.*/

EXCLUDED_PARTNER = 'excluded'
PARTNER = 'alpha'

def registry_accepts_sync_requests
  registry_response with: 201, on: AUTHORIZATIONS_PATH, body: { token: 'ABCDEF' }

  registry_response with: 201, on: ORDERS_PATH
  registry_response with: 201, on: CONTACTS_PATH
  registry_response with: 201, on: HOSTS_PATH

  registry_response with: 201, on: HOST_ADDRESS_PATH
  registry_response with: 200, on: HOST_ADDRESS_PATH, request: :delete

  registry_response with: 201, on: DOMAIN_HOST_PATH

  registry_response with: 200, on: DOMAIN_PATH, request: :patch
  registry_response with: 200, on: DOMAIN_PATH, request: :delete

  registry_response with: 200, on: CONTACT_PATH, request: :patch
end

def exclude_partners
  create :excluded_partner
  create :excluded_partner, name: 'other_excluded'
end

def registry_response on:, with:, request: :post, body: nil
  response = { status: with }
  response[:body] = body.to_json if body

  stub_request(request, on).to_return(response)
end

def sync_latest_changes
  run_sync
end

def sync_error
  registry_response with: 400, on: ORDERS_PATH, body: error_params

  run_sync
end

private

def run_sync
  SyncLog.create  since: '2015-01-01 00:00'.in_time_zone,
                  until: '2015-01-01 00:00'.in_time_zone

  begin
    Sync.run
  rescue
    @exception_thrown = true
  end
end

def default_headers
  {
    'Authorization' =>  'Token token="ABCDEF"',
    'Content-Type'  =>  'application/json'
  }
end

def error_params
  {
    message: 'ERROR MESSAGE'
  }
end

def assert_request method, path, request = nil
  params = {
    headers: default_headers,
  }

  params[:body] = request if request

  url = Rails.configuration.x.registry_url + path

  assert_requested method, url, times: 1
  assert_requested method, url, params
end

def assert_delete path, request = nil
  assert_request :delete, path, request
end

def assert_patch path, request = nil
  assert_request :patch, path, request
end

def assert_post path, request = nil
  assert_request :post, path, request
end

def create_contact_request
  {
    partner: 'alpha',
    handle: 'handle',
    name: 'Contact Name',
    organization: 'Contact Organization',
    street: 'Contact Street',
    street2: 'Contact Street 2',
    street3: 'Contact Street 3',
    city: 'Contact City',
    state: 'Contact State',
    postal_code: '1234',
    country_code: 'PH',
    local_name: 'Local Contact Name',
    local_organization: 'Local Contact Organization',
    local_street: 'Local Contact Street',
    local_street2: 'Local Contact Street 2',
    local_street3: 'Local Contact Street 3',
    local_city: 'Local Contact City',
    local_state: 'Local Contact State',
    local_postal_code: 'Local 1234',
    local_country_code: 'Local PH',
    voice: '+63.21234567',
    voice_ext: '1234',
    fax: '+63.21234567',
    fax_ext: '1235',
    email: 'test@contact.ph'
  }
end

def create_host_request
  {
    partner: 'alpha',
    name: 'ns5.domains.ph'
  }
end

def create_host_address_request
  {
    address: '123.123.123.001',
    type: 'v4'
  }
end

def create_domain_host_entry_request
  {
    name: 'ns5.domains.ph'
  }
end

def update_contact_request
  {
    name: 'Contact Name',
    organization: 'Contact Organization',
    street: 'Contact Street',
    street2: 'Contact Street 2',
    street3: 'Contact Street 3',
    city: 'Contact City',
    state: 'Contact State',
    postal_code: '1234',
    country_code: 'PH',
    local_name: 'Local Contact Name',
    local_organization: 'Local Contact Organization',
    local_street: 'Local Contact Street',
    local_street2: 'Local Contact Street 2',
    local_street3: 'Local Contact Street 3',
    local_city: 'Local Contact City',
    local_state: 'Local Contact State',
    local_postal_code: 'Local 1234',
    local_country_code: 'Local PH',
    voice: '+63.21234567',
    voice_ext: '1234',
    fax: '+63.21234567',
    fax_ext: '1235',
    email: 'test@contact.ph'
  }
end

def update_domain_request
  {
    registrant_handle: 'registrant',
    authcode: 'ABC123',
    client_hold: false,
    client_delete_prohibited: false,
    client_renew_prohibited: false,
    client_transfer_prohibited: false,
    client_update_prohibited: false
  }
end

def update_domain_contact_request
  {
    registrant_handle: 'registrant',
    authcode: 'ABC123',
    client_hold: false,
    client_delete_prohibited: false,
    client_renew_prohibited: false,
    client_transfer_prohibited: false,
    client_update_prohibited: false,
    admin_handle: 'handle'
  }
end
