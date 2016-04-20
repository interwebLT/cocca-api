class DomainHostsController < SecureController
  def destroy
    domain_host = DomainHost.new  domain: params[:domain_id],
                                  name: params[:id]

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
