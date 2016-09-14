class HostAddressesController < SecureController
  def create
    host = Host.new host_params

    unless params[:ip_list].nil?
      ip_list = params[:ip_list]
    else
      ip_list = nil
    end

    result = host.add_address address_params, ip_list

    if result
      render json: result
    else
      head :unprocessable_entity
    end
  end

  def destroy
    unless params[:ip_list].nil?
      ip_list = params[:ip_list]
    else
      ip_list = nil
    end
    host_name    = params[:host_id]
    address      = params[:id]
    host         = Host.new host_params
    result       = host.delete_address host_name, address, ip_list

    if result
      render json: {}
    else
      head :unprocessable_entity
    end
  end

  private

  def host_params
    allowed_params = params.permit :host_id
    allowed_params[:name] = allowed_params.delete(:host_id)
    allowed_params[:partner] = current_partner

    allowed_params
  end

  def address_params
    params.permit :address, :type
  end
end
