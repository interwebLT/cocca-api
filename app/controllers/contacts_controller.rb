class ContactsController < ApplicationController
  def create
    result = {
      name: params[:name],
      organization: nil,
      street: nil,
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
      voice:  nil,
      voice_ext:  nil,
      fax:  nil,
      fax_ext:  nil,
      email:  'contact@test.ph'
    }

    render json: result
  end
end
