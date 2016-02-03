require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let(:customer) { build(:customer) }
  let(:user) { create(:user, customer: customer) }

  before(:each) do
    #@user = create(:user, customer: create(:customer))
    allow(User).to receive(:find).with(user.id.to_s).and_return(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

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
    end

    context "when User has not registered Customer profile" do
      before(:each) do
        user.update_attribute(:customer, nil)
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
    end
  end

  describe 'POST #create' do

  end
end
