require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  REQUIRED_FIELDS = %w{ number CVV expiration_month expiration_year 
    firstname lastname }

  context 'Attributes' do
    REQUIRED_FIELDS.each do |attribute|
      it { should respond_to(attribute) }
    end
  end

  context 'Validation' do
    it 'is valid if all attributes are provided' do
      expect(build(:credit_card)).to be_valid
    end

    REQUIRED_FIELDS.each do |attribute|
      it "is invalid if #{attribute} does not provided" do
        expect(build(:credit_card, "#{attribute}".to_sym => nil)).to be_invalid
      end
    end
  end

  context 'Associations' do
    it "belongs to 'customer'" do
      expect(create(:credit_card)).to respond_to(:customer)
    end

    it "has many 'orders'" do
      expect(create(:credit_card)).to respond_to(:orders)
    end
  end

  context 'Callbacks' do

  end

  context 'Class and instance methods' do

  end
end
