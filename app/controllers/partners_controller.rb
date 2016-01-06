class PartnersController < ApplicationController
  def create
    Partner.create partner_params

    head :created
  end

  private

  def partner_params
    params.permit :name, :password
  end
end
