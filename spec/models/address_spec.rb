require 'rails_helper'

RSpec.describe Address, type: :model do
  REQUIRED_FIELDS = %w{ address zipcode city phone country }

  context 'Attributes' do
    REQUIRED_FIELDS.each do |attribute|
      it { should respond_to(attribute) }
    end
  end

  context 'Validation' do
    it 'is valid if all attributes are provided' do
      expect(build(:address)).to be_valid
    end

    REQUIRED_FIELDS.each do |attribute|
      it "is invalid if #{attribute} does not provided" do
        expect(build(:address, "#{attribute}" => nil)).to be_invalid
      end
    end
  end
end
