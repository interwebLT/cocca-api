class DomainsController < SecureController
  def update
    domain = Domain.new domain_params

    if domain.valid? and domain.update_authcode(domain_params[:authcode])
      head :ok
    else
      head :unprocessable_entity
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
