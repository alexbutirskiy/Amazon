require 'rails_helper'

RSpec.describe Book, type: :model, focus: false do
  IN_STOCK = 12
  OUT_OF_STOCK = 8

  context 'Attributes' do
    %w(title description price in_stock sold).each do |attribute|
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

    it { should validate_numericality_of(:in_stock)
          .is_greater_than_or_equal_to(0) }

    it { should validate_numericality_of(:sold).is_greater_than_or_equal_to(0) }
  end

  context 'Associations' do
    it { should belong_to(:category) }
    it { should have_many(:authors) }
  end

  context 'Callbacks' do
    it "sets 'in_stock' with zero as default" do
      expect(Book.new.in_stock).to be_zero
    end

    it "sets 'sold' with zero as default" do
      expect(Book.new.sold).to be_zero
    end
  end

  context 'Class and instance methods' do
    describe '.in_stock and .out_of_stock methods:' do
      before do
        @in_stock = create_list(:book, IN_STOCK)
        @out_of_stock = create_list(:out_of_stock_book, OUT_OF_STOCK)
      end

      it '.in_stock returns a list of books in stock' do
        expect(Book.in_stock).to eq @in_stock
      end

      it '.out_of_stock returns a list of books out of stock' do
        expect(Book.out_of_stock).to eq @out_of_stock
      end
    end

    describe '.bestseller' do
      before do
        @book_best = create(:book, sold: 10)
        @book_worst = create(:book, sold: 0)
        @book = create(:book, sold: 5)
      end
      it'returns proper book according to place given' do
        expect(Book.bestseller(1)).to eq @book_best
        expect(Book.bestseller(2)).to eq @book
        expect(Book.bestseller(3)).to eq @book_worst
      end

      it'raises ActiveRecord::RecordNotFound exeption if place < 1 given' do
        expect { Book.bestseller(0) }.to raise_exception ActiveRecord::RecordNotFound
      end

      it'raises ActiveRecord::RecordNotFound exeption if place > BESTSELLERS_COUNT given' do
        new_count = 2
        Kernel::silence_warnings { Book.const_set :BESTSELLERS_COUNT, new_count }
        expect { Book.bestseller(new_count + 1) }.
          to raise_exception ActiveRecord::RecordNotFound
      end

      it'raises ActiveRecord::RecordNotFound exeption if place > Book.count given' do
        new_count = 10
        Kernel::silence_warnings { Book.const_set :BESTSELLERS_COUNT, new_count }
        expect { Book.bestseller(new_count - 1) }.
          to raise_exception ActiveRecord::RecordNotFound
      end
    end

    describe '.bestsellers_max' do
      before do
        @book_best = create(:book, sold: 10)
        @book_worst = create(:book, sold: 0)
        @book = create(:book, sold: 5)
      end

      context 'when actial number of bestsellers is reduced by :BESTSELLERS_COUNT' do
        it 'returns Book::BESTSELLERS_COUNT' do
           Kernel::silence_warnings { Book.const_set :BESTSELLERS_COUNT, 2 }
          expect(Book.bestsellers_max).to eq Book::BESTSELLERS_COUNT
        end
      end

      context 'when actial number of bestsellers is reduced by Book.count' do
        it 'returns Book.count' do
           Kernel::silence_warnings { Book.const_set :BESTSELLERS_COUNT, 10 }
          expect(Book.bestsellers_max).to eq Book.count
        end
      end
    end
  end
end
