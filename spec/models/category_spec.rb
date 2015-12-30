require 'rails_helper'

RSpec.describe Category, type: :model do
  REPEITED_TITLE = 'A title'
  context 'Attributes' do
    it { should have_db_column(:title) }
    it { should respond_to(:title) }
  end

  context 'Validations' do
    it 'is valid if title presents and is uniq' do
      expect(build(:category)).to be_valid
    end

    it 'is invalid if not uniq title is provided' do
      create(:category, title: REPEITED_TITLE)
      expect(build(:category, title: REPEITED_TITLE)).to be_invalid
    end

    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    
  end

  context 'Associations' do
    it { should have_many(:books) }
  end
end
