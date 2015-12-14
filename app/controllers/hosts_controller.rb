class HostsController < SecureController
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
    allowed_params = params.permit :name
    allowed_params[:partner] = current_partner

    allowed_params
  end
end
