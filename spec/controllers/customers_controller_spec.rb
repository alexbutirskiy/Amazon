require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let(:customer) { build(:customer) }
  let(:user) { create(:user, customer: customer) }
  let(:customer_params) { customer.attributes.stringify_keys }
  let(:address) { build(:address) }
  let(:address_params) { address.attributes.stringify_keys }

  before(:each) do
    allow(User).to receive(:find).with(user.id.to_s).and_return(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  it { should use_before_filter(:authenticate_user!) }

  describe "GET #edit" do
    context "when User has Customer profile registered" do
      it 'assigns @user' do
        get(:edit, user_id: user.id)
        expect(assigns(:user)).to eq user
      end

      it 'assigns @customer' do
        get(:edit, user_id: user.id)
        expect(assigns(:customer)).to eq user.customer
      end

      it 'sets billing and shipping addresses' do
        expect(controller).to receive(:set_addresses)
        get(:edit, user_id: user.id)
      end

      it 'renders :edit template' do
        get(:edit, user_id: user.id)
        expect(response).to render_template(:edit)
      end
    end

    context "when User has not registered Customer profile" do
      before(:each) do
        user.update_attribute(:customer, nil)
      end

      it 'assigns @user' do
        get(:edit, user_id: user.id)
        expect(assigns(:user)).to eq user
      end

      it 'assigns @customer' do
        expect(Customer).to receive(:new).and_return(customer)
        get(:edit, user_id: user.id)
        expect(assigns(:customer)).to eq customer
      end

      it 'sets billing and shipping addresses' do
        expect(controller).to receive(:set_addresses)
        get(:edit, user_id: user.id)
      end

      it 'renders :new template' do
        get(:edit, user_id: user.id)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #create' do
    it { should permit(:firstname, :lastname).
          for(:create, params: {user_id: user.id, customer: customer_params}).
          on(:customer) }

    it 'assigns @user' do
      post(:create, user_id: user.id, customer: customer_params)
      expect(assigns(:user)).to eq user
    end

    it 'creates customer and assigns @customer' do
      user_customer = double('UserCustomer')
      expect_any_instance_of(CustomersController).to receive(:customer_params).
                                                      and_return(customer_params)

      expect(user).to receive(:build_user_customer).and_return(user_customer)
      expect(user_customer).to receive(:create_customer).with(customer_params).
                                                          and_return(customer)
      post(:create, user_id: user.id, customer: customer_params)
    end

    it "flashes notice according to customer save status" do
      allow(user).to receive_message_chain(:build_user_customer, :create_customer)
                      .and_return(customer)
      expect(controller).to receive(:display_flash).with(customer, any_args)
      post(:create, user_id: user.id, customer: customer_params)
    end

    it 'sets billing and shipping addresses' do
      expect(controller).to receive(:set_addresses)
      post(:create, user_id: user.id, customer: customer_params)
    end

    it 'renders :edit template' do
      get(:edit, user_id: user.id)
      post(:create, user_id: user.id, customer: customer_params)
    end

    context 'when parametres are valid' do
      before { post(:create, user_id: user.id, customer: customer_params) }
      it 'renders :edit template' do
        expect(response).to render_template(:edit)
      end

      it "flashes 'Customer has been created' notice" do
        expect(flash[:notice]).to eq 'Customer has been created'
      end
    end

    context 'when parametres are invalid' do
      before do 
        customer_params[:firstname] = ''
        post(:create, user_id: user.id, customer: customer_params)
      end
      it 'renders :edit template' do
        expect(response).to render_template(:new)
      end

      it "flashes 'Firstname can't be blank' alert" do
        expect(flash[:alert]).to eq "Firstname can't be blank"
      end
    end
  end

  describe 'PATCH #update' do
    it { should permit(:firstname, :lastname).
          for(:update, params: { id: customer.id, customer: customer_params }).
          on(:customer) }

    it 'assigns @user' do
      patch(:update, id: customer.id, customer: customer_params)
      expect(assigns(:user)).to eq user
    end

    it 'assigns @customer' do
      patch(:update, id: customer.id, customer: customer_params)
      expect(assigns(:customer)).to eq customer
    end

    it 'sets billing and shipping addresses' do
      expect(controller).to receive(:set_addresses)
      patch(:update, id: customer.id, customer: customer_params)
    end

    context 'when parametres are valid' do
      it "flashes 'Customer has been updated' notice" do
        patch(:update, id: customer.id, customer: customer_params)
        expect(flash[:notice]).to eq "Customer has been updated"
      end
    end

    context 'when parametres are invalid' do
      it "flashes 'can't be blank' alert" do
        customer_params[:firstname] = ''
        patch(:update, id: customer.id, customer: customer_params)
        expect(flash[:alert]).to match("can't be blank")
      end
    end
  end

  describe 'POST #create_billing_address' do
    it { should permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country).
        for(:create_billing_address, 
            params: { customer_id: customer.id, address: address_params }, 
            verb: :post).
        on(:address) }

    it 'assigns @user' do
      post(:create_billing_address, customer_id: customer.id, address: address_params)
      expect(assigns(:user)).to eq user
    end

    it 'assigns @customer' do
      post(:create_billing_address, customer_id: customer.id, address: address_params)
      expect(assigns(:customer)).to eq customer
    end

    it 'sets billing and shipping addresses' do
      expect(controller).to receive(:set_addresses)
      post(:create_billing_address, customer_id: customer.id, address: address_params)
    end

    context 'when parametres are valid' do
      it "flashes 'Billing address has been created' notice" do
        post(:create_billing_address, customer_id: customer.id, address: address_params)
        expect(flash[:notice]).to eq "Billing address has been created"
      end
    end

    context 'when parametres are invalid' do
      it "flashes 'Billing address has been updated' notice" do
        address_params[:city] = ''
        post(:create_billing_address, customer_id: customer.id, address: address_params)
        expect(flash[:alert]).to match("can't be blank")
      end
    end
  end

  describe 'PATCH #update_billing_address' do
    before(:each) do
      allow(Customer).to receive(:find).with(customer.id.to_s).and_return(customer)
      allow(customer).to receive(:billing_address).and_return(address)
      allow(address).to receive(:update)
    end

    it { should permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country).
        for(:update_billing_address, 
            params: { customer_id: customer.id, address: address_params }, 
            verb: :patch).
        on(:address) }

    it 'assigns @user' do
      patch(:update_billing_address, customer_id: customer.id, address: address_params)
      expect(assigns(:user)).to eq user
    end

    it 'assigns @customer' do
      patch(:update_billing_address, customer_id: customer.id, address: address_params)
      expect(assigns(:customer)).to eq customer
    end

    it 'sets billing and shipping addresses' do
      expect(controller).to receive(:set_addresses)
      patch(:update_billing_address, customer_id: customer.id, address: address_params)
    end

    context 'when parametres are valid' do
      it "flashes 'Billing address has been updated' notice" do
        patch(:update_billing_address, customer_id: customer.id, address: address_params)
        expect(flash[:notice]).to eq "Billing address has been updated"
      end
    end

    context 'when parametres are invalid' do
      it "flashes 'Billing address has been updated' notice" do
        address.errors.add(:city, "can't be blank")
        patch(:update_billing_address, customer_id: customer.id, address: address_params)
        expect(flash[:alert]).to match("can't be blank")
      end
    end
  end

  describe 'POST #create_shipping_address' do
    it { should permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country).
        for(:create_shipping_address, 
            params: { customer_id: customer.id, address: address_params }, 
            verb: :post).
        on(:address) }

    it 'assigns @user' do
      post(:create_shipping_address, customer_id: customer.id, address: address_params)
      expect(assigns(:user)).to eq user
    end

    it 'assigns @customer' do
      post(:create_shipping_address, customer_id: customer.id, address: address_params)
      expect(assigns(:customer)).to eq customer
    end

    it 'sets billing and shipping addresses' do
      expect(controller).to receive(:set_addresses)
      post(:create_shipping_address, customer_id: customer.id, address: address_params)
    end

    context 'when parametres are valid' do
      it "flashes 'Shipping address has been created' notice" do
        post(:create_shipping_address, customer_id: customer.id, address: address_params)
        expect(flash[:notice]).to eq "Shipping address has been created"
      end
    end

    context 'when parametres are invalid' do
      it "flashes 'can't be blank' alert" do
        address_params[:city] = ''
        post(:create_shipping_address, customer_id: customer.id, address: address_params)
        expect(flash[:alert]).to match("can't be blank")
      end
    end
  end

  describe 'PATCH #update_shipping_address' do
    before(:each) do
      allow(Customer).to receive(:find).with(customer.id.to_s).and_return(customer)
      allow(customer).to receive(:shipping_address).and_return(address)
      allow(address).to receive(:update)
    end

    it { should permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country).
        for(:update_shipping_address, 
            params: { customer_id: customer.id, address: address_params }, 
            verb: :patch).
        on(:address) }

    it 'assigns @user' do
      patch(:update_shipping_address, customer_id: customer.id, address: address_params)
      expect(assigns(:user)).to eq user
    end

    it 'assigns @customer' do
      patch(:update_shipping_address, customer_id: customer.id, address: address_params)
      expect(assigns(:customer)).to eq customer
    end

    it 'sets billing and shipping addresses' do
      expect(controller).to receive(:set_addresses)
      patch(:update_shipping_address, customer_id: customer.id, address: address_params)
    end

    context 'when parametres are valid' do
      it "flashes 'Shipping address has been updated' notice" do
        patch(:update_shipping_address, customer_id: customer.id, address: address_params)
        expect(flash[:notice]).to eq "Shipping address has been updated"
      end
    end

    context 'when parametres are invalid' do
      it "flashes 'can't be blank' alert" do
        address.errors.add(:city, "can't be blank")
        patch(:update_shipping_address, customer_id: customer.id, address: address_params)
        expect(flash[:alert]).to match("can't be blank")
      end
    end
  end
end
