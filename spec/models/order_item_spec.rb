require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  requaired_fields = %w{ price quantity }

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

    requaired_fields.each do |attribute|
      it { should validate_presence_of(attribute) }
    end
  end

  context 'Associations' do
    %w{ order book }.each do |association|
      it { should belong_to(association) }
    end
  end
end
