require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:customer) { create(:customer) }
  let(:user) { create(:user, customer: customer) }

  before(:each) do
    allow(User).to receive(:find).with(user.id.to_s).and_return(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe 'Private method find_order' do
    order_states = %w(cart wait_addresses wait_delivery wait_payment)

    order_states.each do |state|
      it "returns order with '#{state}'' state" do
        order = create(:order, customer: customer, state: "#{state}")
        expect(controller.send(:cart_order)).to eq order
      end
    end
  end
end