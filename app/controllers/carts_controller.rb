class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_items, only: [:show, :update]

  def show
  end

  def update
    @items.each do |item|
      new_qty = quantity_params[item.id.to_s].to_i
      if new_qty && new_qty != item.quantity
        item.update_attributes!(quantity: new_qty)
        @subtotal = calc_subtotal
      end
    end

    render(:show)
  end

  def destroy
    order = Order.find_by(customer: current_user.customer, state: 'cart')
    order.delete if order

    redirect_to(books_path)
  end

  def checkout
    order = Order.find_by(customer: current_user.customer, state: 'cart')
    order.checkout!
    redirect_to(cart_path)
  end


  private

  def quantity_params
    params.require(:quantity)
  end

  def prepare_items
    order = Order.find_by(customer: current_user.customer, state: 'cart')
    order ||= Order.new(customer: current_user.customer)

    @items = order.order_items
    @subtotal = calc_subtotal
  end

  def calc_subtotal
        @items.inject(0) do |sum, item|  
      sum + item.price * item.quantity
    end
  end
end