require 'rails_helper'

RSpec.describe Customer, type: :model do
  REQUIRED_FIELDS = %w{ email password firstname lastname }
  REPEATED_EMAIL = 'somebody@somewhere.com'

  context 'Attributes' do
    REQUIRED_FIELDS.each do |attribute|
      it { should respond_to(attribute) }
    end
  end

  context 'Validation' do
    it 'is valid if all attributes are provided' do
      expect(build(:customer)).to be_valid
    end

    REQUIRED_FIELDS.each do |attribute|
      it "is invalid if #{attribute} does not provided" do
        expect(build(:customer, "#{attribute}" => nil)).to be_invalid
      end
    end

    it 'is valid if email is not uniq' do
      create(:customer, email: REPEATED_EMAIL)
      expect(build(:customer, email: REPEATED_EMAIL)).to be_invalid
    end
  end

  context 'Associations' do
    %w{ orders ratings }.each do |association|
      it "has many '#{association}'" do
        expect(create(:customer)).to respond_to(:association)
      end
    end
  end

  context 'Callbacks' do

  end

  context 'Class and instance methods' do

  end
end
