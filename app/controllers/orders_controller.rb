class OrdersController < ApplicationController
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

  def order_params
    params.permit :currency_code, :ordered_at, :order_details => [
      :type, :domain, :authcode, :period, :registrant_handle
      ]
  end
end
