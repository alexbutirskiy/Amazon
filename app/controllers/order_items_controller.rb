class OrderItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.customer
      book = Book.find(params[:book_id])
      order = Order.find_by(customer: current_user.customer, state: 'cart') || 
                Order.new(customer: current_user.customer)

      order.add_book(book, params[:quantity])
      redirect_to (:cart)
    else
      session[:return_to] = new_book_review_path(params[:book_id])
      redirect_to(edit_user_customer_path(current_user), 
        alert: 'Register your name first')
    end
  end

  def destroy
    OrderItem.find(params[:id]).destroy
    redirect_to (:cart)
  end
end