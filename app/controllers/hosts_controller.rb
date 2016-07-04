class HostsController < SecureController
  def create
    host = Host.new host_params

    if host.save
      render json: host
    else
      head :unprocessable_entity
    end
  end

  def show
    name  = params[:id]
    host  = Host.new partner: current_partner

    if host.exists? name: name
      result = { id: 1, name: name }

      render json: result
    else
      result = { message: 'Not Found' }

      render status: :not_found, json: result
    end
  end

  private
  def host_params
    allowed_params = params.permit :name
    allowed_params[:partner] = current_partner

    allowed_params
  end
end
