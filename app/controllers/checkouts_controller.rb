class CheckoutsController < ApplicationController
  before_action :find_order

  def edit_addresses
    @billing_address = @order.billing_address || 
      current_user.customer.billing_address ||
        Address.new
    @shipping_address = @order.shipping_address || 
      current_user.customer.shipping_address ||
        Address.new
  end

  def update_addresses
    byebug
    auto_fields = ['id', 'created_at', 'updated_at']
    if @order.billing_address
      @order.billing_address.assign_attributes(billing_addr_params)
    else
      address = Address.new(billing_addr_params)
      byebug
      if(address.valid?)
        @order.billing_address = address
      end

    end


    byebug
  end

  private

  def billing_addr_params
    params.require(:billing_address).
      permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country)
  end

  def shipping_addr_params
    params.require(:shipping_address).
      permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country)
  end

  def find_order
    @order = Order.find(params[:order_id])
  end
end