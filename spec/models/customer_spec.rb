require 'rails_helper'

RSpec.describe Customer, type: :model do
  requaired_fields = %w(firstname lastname)
  REPEATED_EMAIL = 'somebody@somewhere.com'

  context 'Attributes' do
    requaired_fields.each do |attribute|
      it { should respond_to(attribute) }
      it { should respond_to(attribute) }
    end
  end

  context 'Validation' do
    it 'is valid if all attributes are provided' do
      expect(build(:customer)).to be_valid
    end

    requaired_fields.each do |attribute|
      it { should validate_presence_of(attribute) }
    end
  end

  context 'Associations' do
    %w(orders ratings).each do |association|
      it { should have_many(association) }
    end

    it { should have_one(:site_account) }
  end

  context 'Callbacks' do
  end

  context 'Class and instance methods' do
    it 'should create new order' do
      expect(build(:customer).orders).to respond_to :new
    end

    describe '#order_in_progress' do
      it "returns an order with status 'in_progress'" do
        customer = create(:customer)
        create_list(:order, 10, 
          customer: customer, 
          state: Order::States::COMPLETED)
        order = Order.all.order("RANDOM()").first
        order.update(state: 'in_progress')

        expect(customer.order_in_progress).to eq order
      end
    end
  end
end
