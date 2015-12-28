require 'rails_helper'

RSpec.describe Book, type: :model, focus: false do
  IN_STOCK = 12
  OUT_OF_STOCK = 8

  context 'Attributes' do
    %w{ title description price in_stock }.each do |attribute|
      it { should respond_to(attribute) }
    end
  end

  context 'Validation' do
    it "is valid if 'title', 'price', 'in_stock' are provided" do
      expect(build(:book)).to be_valid
    end

    it "is invalid without a 'title'" do
      expect(build(:book, title: nil).errors[:title]).to include("can't be blank")
    end

    it "is invalid without a 'price'" do
      expect(build(:book, price: nil).errors[:price]).to include("is not a number")
    end

    it "is invalid if 'price' is not a numeric" do
      expect(build(:book, price: 'ten')).to be_invalid
    end    

    it "does not allow 'price' to be zero or negative" do
      expect(build(:book, price: 0)).to be_invalid
      expect(build(:book, price: -1)).to be_invalid
    end

    it "does not allow more than 2 digits after a point in a 'price'" do
      expect(build(:book, price: 10.235)).to be_invalid
    end

    it "is invalid if 'in_stock' is not a numeric" do
      expect(build(:book, in_stock: 'two')).to be_invalid
    end

    it "is invalid if 'in_stock' is less than 0" do
      expect(build(:book, in_stock: -1)).to be_invalid
    end
  end

  context 'Associations' do
    %w{ author category }.each do |a|
      it "belongs to '#{a}'" do
        expect(create(:book)).to respond_to(a)
      end
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
      create_list(:book, IN_STOCK)
      create_list(:out_of_stock_book, OUT_OF_STOCK)
    end

    it "returns a list of books in stock" do
      expect(Book.in_stock.size).to eq IN_STOCK
    end

    it "returns a list of books out of stock" do
      expect(Book.out_of_stock.size).to eq OUT_OF_STOCK
    end
  end
end
