class DomainHostsController < SecureController
  def create
    domain_host = DomainHost.new  partner: current_partner,
                                  domain: params[:domain_id],
                                  name:   params[:name]

    if domain_host.create
      render json: domain_host
    else
      head :unprocessable_entity
    end
  end

  def destroy
    domain_host = DomainHost.new  partner:  current_partner,
                                  domain:   params[:domain_id],
                                  name:     params[:id]

    if domain_host.destroy
      render json: domain_host
    else
      head :unprocessable_entity
    end
  end
end
