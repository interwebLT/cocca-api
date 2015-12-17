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

def exclude_partners
  create :excluded_partner
  create :excluded_partner, name: 'other_excluded'
end

def registry_response on:, with:, request: :post, body: nil
  response = { status: with }
  response[:body] = body.to_json if body

  stub_request(request, on).to_return(response)
end

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
