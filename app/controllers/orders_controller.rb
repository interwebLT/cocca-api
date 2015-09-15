class OrdersController < ApplicationController
  def create
    order = Order.new order_params

    if order.save
      render json: order
    else
      head :unprocessable_entity
    end
  end
end
