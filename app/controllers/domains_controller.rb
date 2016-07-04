class DomainsController < SecureController
  def update
    domain = Domain.new domain_params

    if domain.valid? and domain.update_authcode(domain_params[:authcode])
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def show
    domain = Domain.new
    domain.partner = current_partner

    if domain.exists? name: params[:id]
      result = { id: 1, name: params[:id] }

      render json: result
    else
      result = { message: 'Not Found' }

      render status: :not_found, json: result
    end
  end

  private

  def domain_params
    allowed_params = params.permit :id, :registrant_handle, :authcode
    allowed_params[:name] = allowed_params.delete(:id)
    allowed_params[:partner] = current_partner

    allowed_params
  end
end
