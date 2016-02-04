class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:edit, :create, :update_email, :update_password]
  before_action :find_customer_user, only: [  :update,
                                              :create_billing_address,
                                              :update_billing_address,
                                              :create_shipping_address,
                                              :update_shipping_address ]
  def edit
    @customer =  @user.customer

    unless @customer
      @customer = Customer.new
      render :new
    end
    set_addresses
  end

  def create
    @customer = @user.build_user_customer.create_customer(customer_params)
    display_flash(@customer, "Customer has been created")
    set_addresses
    if @customer.new_record? 
      render(:new)
    else
      session[:return_to] ? redirect_to(session.delete(:return_to)) : render(:edit)
    end
  end

  def update
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
    @user.email = params[:user][:email]
    @user.save
    display_flash(@user, 'Email updated')

    @customer =  @user.customer

    unless @customer
      @customer = Customer.new
      render :new
    else
      set_addresses
      render :edit
    end
  end

  def update_password
    @user.update_with_password(user_params)
    display_flash(@user, 'Password updated')

    @customer =  @user.customer

    unless @customer
      @customer = Customer.new
      render :new
    else
      set_addresses
      render :edit
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_customer_user
    @customer = Customer.find(params[:customer_id] || params[:id])
    @user = @customer.site_account
  end

  def customer_params
    params.require(:customer).permit(:firstname, :lastname)
  end

  def address_params
    params.require(:address).
      permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country)
  end

  def user_params
    params.require(:user).permit(:email, :password, :current_password)
  end

  def humanize(s)
    "#{s.to_s.gsub('_', ' '). capitalize}"
  end

  def set_addresses
    @billing_address ||= @customer.billing_address || Address.new
    @shipping_address ||= @customer.shipping_address || Address.new
  end

  def create_address(address_type)
    address = @customer.send("create_#{address_type}", address_params)
    instance_variable_set("@#{address_type}", address)

    display_flash(address, "#{humanize(address_type)} has been created")
    @customer.save if @customer.send("#{address_type}_id_changed?")

    set_addresses
  end

  def update_address(address_type)
    address = @customer.send("#{address_type}")
    address.update(address_params)
    instance_variable_set("@#{address_type}", address)

    display_flash(address, "#{humanize(address_type)} has been updated")
    @customer.save if @customer.send("#{address_type}_id_changed?")


    set_addresses
  end
end
