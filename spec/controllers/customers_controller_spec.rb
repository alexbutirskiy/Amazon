require 'rails_helper'

def test_addresses
  it 'sets billing and shipping addresses' do
    expect(controller).to receive(:set_addresses)
    get(:edit, user_id: @user.id)
  end
end

RSpec.describe CustomersController, type: :controller do
  before(:each) do
    @user = create(:user, customer: create(:customer))
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in @user
  end

  describe "GET #edit" do
    before(:each) do
      get(:edit, user_id: @user.id)
    end

    context "when User has Customer profile registered" do
      it 'assigns @user' do
        expect(assigns(:user)).to eq @user
      end

      it 'assigns @customer' do
        expect(assigns(:customer)).to eq @user.customer
      end

      test_addresses
    end

    context "when User has not registered Customer profile" do
      before(:each) do
        @user.update_attribute(:customer, nil)
      end

      it 'assigns @customer' do
        CUSTOMER = 'Customer'
        expect(Customer).to receive(:new).and_return(CUSTOMER)
        get(:edit, user_id: @user.id)
        expect(assigns(:customer)).to eq CUSTOMER
      end

      test_addresses
    end
  end
end
