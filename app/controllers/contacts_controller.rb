class ContactsController < ApplicationController
  def create
    contact = Contact.new contact_params

    contact.save

    render json: contact
  end

  private

  def contact_params
    params.permit(:handle, :name, :street, :city, :country_code, :voice, :email)
  end
end
