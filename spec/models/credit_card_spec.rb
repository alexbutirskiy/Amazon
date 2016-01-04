require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  requaired_fields = %w(number CVV expiration_month expiration_year firstname
                        lastname)

  context 'Attributes' do
    requaired_fields.each do |attribute|
      it { should have_db_column(attribute) }
      it { should respond_to(attribute) }
    end
  end

  context 'Validation' do
    it 'is valid if all attributes are provided' do
      expect(build(:credit_card)).to be_valid
    end

    requaired_fields.each do |attribute|
      it { should validate_presence_of(attribute) }
    end
  end

  context 'Associations' do
    it { should belong_to(:customer) }
    it { should have_many(:orders) }
  end

  context 'Callbacks' do
  end

  context 'Class and instance methods' do
  end
end
