class HostsController < ApplicationController
  def create
    host = Host.new host_params

    if host.save
      render json: host
    else
      head :unprocessable_entity
    end
  end

  private
  def host_params
    params.permit :name
  end
end
