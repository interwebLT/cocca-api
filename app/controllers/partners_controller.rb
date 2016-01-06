class PartnersController < ApplicationController
  def create
    partner = Partner.new partner_params

    if partner.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def partner_params
    params.permit :name, :password
  end
end
