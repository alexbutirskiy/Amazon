require 'rails_helper'

RSpec.describe Customer, type: :model do
  requaired_fields = %w(email password firstname lastname)
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

    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  context 'Associations' do
    %w(orders ratings).each do |association|
      it { should have_many(association) }
    end
  end

  context 'Callbacks' do
  end

  context 'Class and instance methods' do
    it 'should create new order' do
      expect(build(:customer).orders).to respond_to :new
    end
  end
end
