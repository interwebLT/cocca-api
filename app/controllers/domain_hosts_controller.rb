class DomainHostsController < SecureController
  def destroy
    result = {
      id: 1,
      name: params[:id]
    }

    render json: result
  end
end
