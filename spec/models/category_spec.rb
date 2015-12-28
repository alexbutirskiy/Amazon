require 'rails_helper'

RSpec.describe Category, type: :model do
  REPEITED_TITLE = 'A title'
  context 'Attributes' do
    it { should respond_to(:title) }
  end

  context 'Validations' do
    it 'is valid if title presents and is uniq' do
      expect(build(:category)).to be_valid
    end

    it 'is invalid if no title is provided' do
      expect(build(:category, title: nil)).to be_invalid
    end

    it 'is invalid if not uniq title is provided' do
      create(:category, title: REPEITED_TITLE)
      expect(build(:category, title: REPEITED_TITLE)).to be_invalid
    end
  end

  context 'Associations' do
    it 'has many books' do
      expect(build(:category)).to respond_to(:books)
    end
  end
end
