class HostAddressesController < ApplicationController
  def create
    host = Host.new( name: params[:host_id] )

    result = host.add_address address_params
    if result
      render json: result
    else
      head :unprocessable_entity
    end
  end

  private
  def address_params
    params.permit :address, :type
  end
end
