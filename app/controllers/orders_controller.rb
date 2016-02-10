class OrdersController < ApplicationController
    before_action :authenticate_user!

    def index
      @orders = Order.where(customer: current_user.customer)
    end

    def show
      @order = Order.find(params[:id])
    end
end