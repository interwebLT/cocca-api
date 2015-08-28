class ContactsController < ApplicationController
  def create
    host  = Rails.configuration.x.epp_host
    username  = Rails.configuration.x.epp_username
    password  = Rails.configuration.x.epp_password

    client = EPP::Client.new username, password, host

    command_params = {
      postal_info: {
        name: params[:name],
        org:  nil,
        addr: {
          street: params[:street],
          city: params[:city],
          sp: nil,
          pc: nil,
          cc: params[:country_code]
        }
      },
      voice:  params[:voice],
      fax:  nil,
      email:  params[:email],
      auth_info:  { pw: params[:authcode] }
    }

    command = EPP::Contact::Create.new params[:handle], command_params
    command_response = EPP::Contact::CreateResponse.new client.create(command)

    result = {
      handle: params[:handle],
      name: params[:name],
      organization: nil,
      street: params[:street],
      street2:  nil,
      street3:  nil,
      city: params[:city],
      state:  nil,
      postal_code:  nil,
      country_code: params[:country_code],
      local_name: nil,
      local_organization: nil,
      local_street: nil,
      local_street2:  nil,
      local_street3:  nil,
      local_city: 'City',
      local_state:  nil,
      local_postal_code:  nil,
      local_country_code: nil,
      voice:  params[:voice],
      voice_ext:  nil,
      fax:  nil,
      fax_ext:  nil,
      email:  'contact@test.ph'
    }

    render json: result
  end
end
