class OrdersController < SecureController
  def create
    order = Order.new order_params

    if order.save
      render json: order
    else
      head :unprocessable_entity
    end
  end

  def update
    order = Order.new order_params

    if order.update
      render json: order
    else
      head :unprocessable_entity
    end
  end

  private

  def order_params
    allowed_params = params.permit :currency_code, :ordered_at, order_details: [
      :type, :domain, :authcode, :period, :registrant_handle, :current_expires_at
    ]
    allowed_params[:partner] = current_partner

    allowed_params
  end
end
