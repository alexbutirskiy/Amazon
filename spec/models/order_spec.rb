require 'rails_helper'

RSpec.describe Order, type: :model do
  requaired_fields = %w(total_price completed_date state)
  context 'Attributes' do
    requaired_fields.each do |attribute|
      it { should have_db_column(attribute) }
      it { should respond_to(attribute) }
    end

    it "should sets 'state' to 'in_progress' on initializing" do
      expect(Order.new.state).to eq 'in_progress'
    end
  end

  context 'Validations' do
    it "is valid if 'total_price' 'completed_date' 'state' present" do
      expect(build(:order)).to be_valid
    end

    requaired_fields.each do |attribute|
      it { should validate_presence_of(attribute) }
    end

    it { should validate_inclusion_of(:state).in_array(Order::States.all) }
  end

  context 'Associations' do
    it { should belong_to(:customer) }
    it { should belong_to(:credit_card) }
    it { should have_many(:order_items) }
    it { should belong_to(:billing_address) }
    it { should belong_to(:shipping_address) }
  end

  context 'Callbacks' do
  end

  context 'Class and instance methods' do
    count1 = Faker::Number.number(1).to_i
    count2 = Faker::Number.number(2).to_i
    let(:book) { create(:book) }
    let(:book2) { create(:book) }
    let(:order) { create(:order) }

    it 'has #add_book method' do
      items = double('Order Items')
      expect(order).to receive(:order_items).and_return(items)
      expect(items).to receive(:create)
        .with(book: book, quantity: count1, price: count1 * book.price)
      expect(order).to receive(:save)
      order.add_book book, count1
    end

    it 'recalculates total_price on every update event' do
      order.add_book book, count1
      expect(order.total_price).to eq count1 * book.price
      order.add_book book2, count2
      expect(order.total_price).to eq count1 * book.price + count2 * book2.price
    end
  end
end
