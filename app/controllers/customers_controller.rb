class CustomersController < ApplicationController

  def edit
    @user = User.find(params[:user_id])
    @customer =  @user.customer

    unless @customer
      @customer = Customer.new
      render :new
    end

    @billing_address = @customer.billing_address || Address.new
    @shipping_address = @customer.shipping_address || Address.new
  end

  def create
    @user = User.find(params[:user_id])
    @customer = @user.build_user_customer.create_customer(customer_params)

    display_flash(@customer, "Customer has been created")

    @billing_address = Address.new
    @shipping_address = Address.new
    @customer.new_record? ? render(:new) : render(:edit)
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)

    display_flash(@customer, "Customer has been updated")

    @billing_address = @customer.billing_address || Address.new
    @shipping_address = @customer.shipping_address || Address.new

    render :edit
  end

  def create_billing_address
    @customer = Customer.find(params[:customer_id])
    @billing_address = @customer.create_billing_address(address_params)
    display_flash(@billing_address, 'Billing address has been created')
    @customer.save if @customer.billing_address_id_changed?

    @shipping_address = @customer.shipping_address || Address.new

    render :edit
  end

  def update_billing_address
#    byebug
    @customer = Customer.find(params[:customer_id])
    @billing_address = @customer.billing_address
    @billing_address.update(address_params)

    display_flash(@billing_address, 'Billing address has been updated')
    @customer.save if @customer.billing_address_id_changed?

    @shipping_address = @customer.shipping_address || Address.new

    render :edit
  end

    def create_shipping_address
    @customer = Customer.find(params[:customer_id])
    @shipping_address = @customer.create_shipping_address(address_params)
    display_flash(@shipping_address, 'Shipping address has been created')
    @customer.save if @customer.shipping_address_id_changed?

    @billing_address = @customer.billing_address || Address.new

    render :edit
  end

  def update_shipping_address
    @customer = Customer.find(params[:customer_id])
    @shipping_address = @customer.shipping_address
    @shipping_address.update(address_params)

    display_flash(@shipping_address, 'Shipping address has been updated')
    @customer.save if @customer.shipping_address_id_changed?

    @billing_address = @customer.billing_address || Address.new

    render :edit
  end

  private

  def customer_params
    params.require(:customer).permit(:firstname, :lastname)
  end

  def address_params
    params.require(:address).
      permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country)
  end

  def display_flash(object, on_success = 'Ok')
    if object.errors.empty?
      flash.now[:notice] = on_success
    else
      flash.now[:alert] = object.errors.full_messages.join(', ')
    end
  end
end
