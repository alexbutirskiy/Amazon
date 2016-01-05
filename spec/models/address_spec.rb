require 'rails_helper'

RSpec.describe Address, type: :model do
  requaired_fields = %w(address zipcode city phone country)

  context 'Attributes' do
    requaired_fields.each do |attribute|
      it { should have_db_column(attribute) }
      it { should respond_to(attribute) }
    end
  end

  context 'Validation' do
    it 'is valid if all attributes are provided' do
      expect(build(:address)).to be_valid
    end

    requaired_fields.each do |attribute|
      it { should validate_presence_of(attribute) }
    end
  end

  context 'Class and instance methods' do
    it 'should have #orders method' do
      addr = create(:address)
      order1 = create_list(:order, 10, shipping_address: addr)
      order2 = create_list(:order, 10, billing_address: addr)
      create_list(:order, 10)
      expect(addr.orders).to match_array(order1 + order2)
    end
  end
end
