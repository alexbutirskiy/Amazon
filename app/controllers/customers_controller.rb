class CustomersController < ApplicationController

  def edit
    @user = User.find(params[:user_id])
    @customer =  @user.customer

    unless @customer
      @customer = Customer.new
      render :new
    end

    set_addresses
  end

  def create
    @user = User.find(params[:user_id])
    @customer = @user.build_user_customer.create_customer(customer_params)

    display_flash(@customer, "Customer has been created")

    set_addresses
    @customer.new_record? ? render(:new) : render(:edit)
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)

    display_flash(@customer, "Customer has been updated")

    set_addresses
    render :edit
  end

  def create_billing_address
    create_address(:billing_address)
    render :edit
  end

  def update_billing_address
    update_address(:billing_address)
    render :edit
  end

  def create_shipping_address
    create_address(:shipping_address)
    render :edit
  end

  def update_shipping_address
    update_address(:shipping_address)
    render :edit
  end

  def update_email
    @user = User.find(params[:user_id])
    @user.email = params[:user][:email]
    @user.save
    display_flash(@user, 'Email updated')

    @customer =  @user.customer

    unless @customer
      @customer = Customer.new
      render :new
    end

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

  def humanize(s)
    "#{s.to_s.gsub('_', ' '). capitalize}"
  end

  def set_addresses
    @billing_address ||= @customer.billing_address || Address.new
    @shipping_address ||= @customer.shipping_address || Address.new
  end

  def create_address(address_type)
    @customer = Customer.find(params[:customer_id])

    address = @customer.send("create_#{address_type}", address_params)
    instance_variable_set("@#{address_type}", address)

    display_flash(address, "#{humanize(address_type)} has been created")
    @customer.save if @customer.send("#{address_type}_id_changed?")

    set_addresses
  end

  def update_address(address_type)
    @customer = Customer.find(params[:customer_id])

    address = @customer.send("#{address_type}")
    address.update(address_params)
    instance_variable_set("@#{address_type}", address)

    display_flash(address, "#{humanize(address_type)} has been updated")
    @customer.save if @customer.send("#{address_type}_id_changed?")

    set_addresses
  end
end
