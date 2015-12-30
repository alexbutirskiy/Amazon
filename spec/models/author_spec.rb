require 'rails_helper'

RSpec.describe Author, type: :model do
  AUTHOR_NAME = 'Name'
  AUTHOR_SURNAME = 'Surname'
  context 'Attributes' do
    %w{ firstname lastname biography }.each do |attribute|
      it { should have_db_column(attribute) }
      it { should respond_to(attribute) }
    end
  end

  context 'Validations' do
    it 'is valid if firstname and lastname present' do
      expect(build(:author)).to be_valid
    end

    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
  end

  context 'Associations' do
    it { should have_many(:books) }
  end

  context 'Class and instance methods' do
    it "has a 'name' method" do
      expect(build(:author, firstname: AUTHOR_NAME, lastname: AUTHOR_SURNAME)
        .name).to match("#{AUTHOR_NAME} #{AUTHOR_SURNAME}")
    end
  end
end
