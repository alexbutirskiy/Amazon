class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_items

  def show
    @subtotal = @items.inject(0) do |sum, item|  
      sum + item.price * item.quantity
    end
  end

  def update
    @subtotal = @items.inject(0) do |sum, item|  
      sum + item.price * item.quantity
    end

    @items.each do |item|
      new_qty = quantity_params[item.id.to_s]
      if new_qty && new_qty != item.quantity
        item.update_attribute(:quantity, new_qty)
      end
    end

    render(:show)
  end

  private

  def quantity_params
    params.require(:quantity)
  end

  def get_items
    order = Order.find_by(customer: current_user.customer, state: 'cart') || 
                Order.new(customer: current_user.customer)

    @items = order.order_items
  end
end