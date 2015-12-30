require 'rails_helper'

RSpec.describe Country, type: :model do
  REPEITED_COUNTRY = 'USA'
  context 'Attributes' do
    it { should have_db_column(:name) }
    it { should respond_to(:name) }
  end

  context 'Validations' do
    it "is valid if 'name' is presented and is uniq" do
      expect(build(:country)).to be_valid
    end

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
