require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  requaired_fields = %w(price)

  context 'Attributes' do
    requaired_fields.each do |attribute|
      it { should respond_to(attribute) }
      it { should respond_to(attribute) }
    end
  end

  context 'Validation' do
    it 'is valid if all attributes are provided' do
      expect(build(:order_item)).to be_valid
    end

    it { should validate_presence_of(:price) }

  end

  context 'Associations' do
    %w(order book).each do |association|
      it { should belong_to(association) }
    end
  end

  it "should sets quantity to 0 if quantity < 0" do
    order_item = build(:order_item, quantity: '-1')
    expect(order_item.quantity).to eq 0
  end

  it "should sets quantity to 0 if quantity is not a number" do
    order_item = build(:order_item, quantity: 'abc')
    expect(order_item.quantity).to eq 0
  end
end
