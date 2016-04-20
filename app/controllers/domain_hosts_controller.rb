class DomainHostsController < SecureController
  def destroy
    domain_host = DomainHost.new  domain: params[:domain_id],
                                  name: params[:id]

    domain_host.destroy

    result = {
      id: 1,
      name: params[:id]
    }

    render json: result
  end
end
