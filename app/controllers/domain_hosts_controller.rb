class DomainHostsController < SecureController
  def create
    domain_host = DomainHost.new  partner: current_partner,
                                  domain: params[:domain_id],
                                  name:   params[:name]

    domain_host.create

    result = {
      id: 1,
      name: params[:name]
    }

    render json: result
  end

  def destroy
    domain_host = DomainHost.new  partner:  current_partner,
                                  domain:   params[:domain_id],
                                  name:     params[:id]

    if domain_host.destroy
      result = {
        id: 1,
        name: params[:id]
      }

      render json: result
    else
      head :unprocessable_entity
    end
  end
end
