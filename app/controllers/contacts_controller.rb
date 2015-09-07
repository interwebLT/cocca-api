class ContactsController < ApplicationController
  def create
    contact = Contact.new contact_params

    if contact.save
      render json: contact
    else
      head :bad_request
    end
  end

  private

  def contact_params
    params.permit(:handle, :name, :street, :city, :country_code, :voice, :email, :authcode)
  end
end
