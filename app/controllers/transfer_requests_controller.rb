class TransferRequestsController < SecureController
  
  def create
    request = TransferRequest.new transfer_request_params
    
    if request.save
      result = { message: 'Request sent' }
      render json: result
    else
      result = { message: 'Request error' }
      render status: :not_found, json: result
    end
  end
  
  def destroy
    request = TransferRequest.new transfer_request_params
    
    if request.delete
      result = { message: 'Transfer rejected' }
      render json: result
    else
      result = { message: 'Transfer reject failed' }
      render status: :not_found, json: result
    end
  end
  
  def update
    request = TransferRequest.new transfer_request_params
    
    if request.update
      result = { message: 'Transfer approved' }
      render json: result
    else
      result = { message: 'Transfer approve failed' }
      render status: :not_found, json: result
    end
  end
  
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

  private
  
  def transfer_request_params
    allowed_params = params.permit :domain, :period, :auth_code
    allowed_params[:partner] = current_partner
    
    allowed_params
  end

end