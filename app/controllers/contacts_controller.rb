class ContactsController < SecureController
  def create
    contact = Contact.new contact_params
    contact.authcode = 'placeholder-authcode'

    if contact.save
      render json: contact
    else
      head :unprocessable_entity
    end
  end

  def update
    contact = Contact.new contact_params

    if contact.update
      render json: contact
    else
      head :unprocessable_entity
    end
  end

  private

  def contact_params
    allowed_params = params.permit  :handle, :name, :street, :city, :country_code, :voice,
                                    :email, :authcode,
                                    :organization, :street2, :street3, :state, :postal_code,
                                    :local_name, :local_organization, :local_street, :local_street2,
                                    :local_street3, :local_city, :local_state, :local_postal_code,
                                    :local_country_code,
                                    :voice_ext, :fax, :fax_ext
    allowed_params[:partner] = current_partner

    allowed_params
  end
end
