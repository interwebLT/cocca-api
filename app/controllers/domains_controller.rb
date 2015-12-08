class DomainsController < ApplicationController
  def update
    domain = Domain.new name: params[:id],
                        registrant_handle: params[:registrant_handle]

    if domain.update_authcode params[:authcode]
      head 200
    else
      head :unprocessable_entity
    end
  end
end
