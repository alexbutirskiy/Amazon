require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'Attributes' do
    %w{ firstname lastname biography }.each do |attribute|
      it { should respond_to(attribute) }
    end
  end

  context 'Validations' do
    it 'is valid if firstname and lastname present' do
      expect(build(:author)).to be_valid
    end

    it 'is valid if no firstname provided' do
      expect(build(:author, firstname: nil)).to be_invalid
    end

    it 'is valid if no lastname provided' do
      expect(build(:author, lastname: nil)).to be_invalid
    end
  end

  context 'Associations' do
    it 'has many books' do
      expect(build(:author)).to respond_to(:books)
    end
  end

  context 'Class and instance methods' do
    it "has a 'name' method" do
      expect(build(:author).name).to match("#{AUTHOR_NAME} #{AUTHOR_SURNAME}")
    end
  end
end
