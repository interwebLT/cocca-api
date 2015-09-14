class ContactsController < ApplicationController
  def create
    contact = Contact.new contact_params

    if contact.save
      render json: contact
    else
      head :unprocessable_entity
    end
  end

  private

  def contact_params
    params.permit :handle, :name, :street, :city, :country_code, :voice, :email, :authcode,
                  :organization, :street2, :street3, :state, :postal_code,
                  :local_name, :local_organization, :local_street, :local_street2, :local_street3,
                  :local_city, :local_state, :local_postal_code, :local_country_code,
                  :voice_ext, :fax, :fax_ext
  end
end
