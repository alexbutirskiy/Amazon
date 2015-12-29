require 'rails_helper'

RSpec.describe Rating, type: :model, focus: false do
  context 'Attributes' do
    %w{ text value }.each do |attribute|
      it { should respond_to(attribute) }
    end
  end

  context 'Validations' do
    it 'is valid if value is a number between 1 and 10 inclusively' do
      expect(build(:rating, value: 1)).to be_valid
      expect(build(:rating, value: 5)).to be_valid
      expect(build(:rating, value: 10)).to be_valid
    end

    it 'is invalid if value is out of 1-10 region' do
      expect(build(:rating, value: 0)).to be_invalid
      expect(build(:rating, value: 11)).to be_invalid
    end
  end

  context 'Associations' do
    %w{ book customer }.each do |attribute|
      it "belongs to '#{attribute}'" do
        expect(create(:rating)).to respond_to(attribute)
      end
    end
  end
end
