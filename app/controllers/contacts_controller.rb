class ContactsController < SecureController
  ALLOWED_PARAMS = [
    :name, :street, :city, :country_code, :voice, :email,
    :organization, :street2, :street3, :state, :postal_code,
    :local_name, :local_organization, :local_street, :local_street2, :local_street3,
    :local_city, :local_state, :local_postal_code, :local_country_code,
    :voice_ext, :fax, :fax_ext
  ]

  def create
    contact = Contact.new create_params
    contact.authcode = 'placeholder-authcode'

    if contact.save
      render json: contact
    else
      render validation_failed contact
    end
  end

  def update
    contact = Contact.new update_params

    if contact.update
      render json: contact
    else
      render validation_failed contact
    end
  end

  def show
    handle  = params[:id]
    contact = Contact.new partner:  current_partner

    if contact.exists? handle: handle
      result = { id: 1, handle: handle }

      render json: result
    else
      result = { message: 'Not Found' }

      render status: :not_found, json: result
    end
  end

  private

  def create_params
    allowed_params = params.permit ALLOWED_PARAMS.push(:handle)
    allowed_params[:partner] = current_partner

    allowed_params
  end

  def update_params
    allowed_params = params.permit ALLOWED_PARAMS.push(:id)
    allowed_params[:partner] = current_partner
    allowed_params[:handle] = allowed_params.delete(:id)

    allowed_params
  end
end
