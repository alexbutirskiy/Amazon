require 'rails_helper'

RSpec.describe Book, type: :model, focus: false do
  IN_STOCK = 12
  OUT_OF_STOCK = 8

  context 'Attributes' do
    %w(title description price in_stock).each do |attribute|
      it { should have_db_column(attribute) }
      it { should respond_to(attribute) }
    end
  end

  context 'Validation' do
    it "is valid if 'title', 'price', 'in_stock' are provided" do
      expect(build(:book)).to be_valid
    end

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }

    # it "does not allow more than 2 digits after a point in a 'price'" do
    #   expect(build(:book, price: 10.235)).to be_invalid
    # end

    it { should validate_numericality_of(:in_stock)
          .is_greater_than_or_equal_to(0) }
  end

  context 'Associations' do
    %w(author category).each do |attribute|
      it { should belong_to(attribute) }
    end
  end

  context 'Callbacks' do
    it "sets 'in_stock' with zero if it's not provided" do
      expect(create(:book, in_stock: nil).in_stock).to be_zero
    end

    it "doesn't change 'in_stock' if it's Ok" do
      expect(create(:book, in_stock: IN_STOCK).in_stock).to eq IN_STOCK
    end
  end

  context 'Class and instance methods' do
    before do
      @in_stock = create_list(:book, IN_STOCK)
      @out_of_stock = create_list(:out_of_stock_book, OUT_OF_STOCK)
    end

    it 'returns a list of books in stock' do
      expect(Book.in_stock).to eq @in_stock
    end

    it 'returns a list of books out of stock' do
      expect(Book.out_of_stock).to eq @out_of_stock
    end
  end
end
