class CustomersController < ApplicationController

  def edit
    @user = User.find(params[:user_id])
    @customer =  @user.customer

    unless @customer
      @customer = Customer.new
      render :new
    end
  end

  def create
    @user = User.find(params[:user_id])
    @customer = @user.build_user_customer.create_customer(customer_params)

    display_flash(@customer, "Customer has been created")

    if @customer.new_record?
      render :new
    else
      render :edit
    end
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)

    display_flash(@customer, "Customer has been updated")

    render :edit
  end

  private

  def customer_params
    params.require(:customer).permit(:firstname, :lastname)
  end

  def display_flash(object, on_success = 'Ok')
    if object.errors.empty?
      flash.now[:notice] = "Customer has been updated"
    else
      flash.now[:alert] = object.errors.full_messages.join(', ')
    end
  end
end
