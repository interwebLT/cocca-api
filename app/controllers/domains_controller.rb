class DomainsController < ApplicationController
  def update
    domain = Domain.new name: params[:id]

    if domain.update_authcode params[:registrant_handle], params[:authcode]
      head 200
    else
      head :unprocessable_entity
    end
  end
end
