class TransferRequestsController < SecureController
  
  def show
    domain = params[:id]
    transfer_request = Audit::TransferRequest.last_pending_request domain: domain
    if transfer_request.incomplete?
      render json: transfer_request
    else
      result = { message: 'Not Found' }

      render status: :not_found, json: result
    end
  end

end