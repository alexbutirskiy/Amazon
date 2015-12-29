require 'rails_helper'

RSpec.describe Country, type: :model do
  REPEITED_COUNTRY = 'USA'
  context 'Attributes' do
    it { should respond_to(:name) }
  end

  context 'Validations' do
    it "is valid if 'name' is presented and is uniq" do
      expect(build(:country)).to be_valid
    end

    it 'is invalid if no title is provided' do
      expect(build(:country, name: nil)).to be_invalid
    end

    it 'is invalid if not uniq title is provided' do
      create(:country, name: REPEITED_COUNTRY)
      expect(build(:country, name: REPEITED_COUNTRY)).to be_invalid
    end
  end
end
