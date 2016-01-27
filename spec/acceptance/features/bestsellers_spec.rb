require 'rails_helper'
require 'acceptance/features/features_spec_helper'

feature "Bestsellers" do
  context 'when DB is empty' do
    it "Shows 'There is no books in the Store'" do
      visit "/books/bestsellers/1"
      expect(page).to have_content('There is no books in the Store')
    end
  end

  context 'when DB has book data' do
    before do
      @book = create(:book)
      visit bestseller_path(1)
    end

    it 'Book title is displayed' do
      expect(page).to have_content(@book.title)
    end

    it "Book authors' links are displayed" do
      @book.authors.each do |author|
        expect(page).to have_link("#{author.name}", href: "/authors/#{author.id}")
      end
    end

    it 'Book description is displayed' do
      expect(page).to have_content(@book.description)
    end

    it 'Book price is displayed' do
      expect(page).to have_content(@book.price)
    end
  end

  context 'when 1st bestseller is displayed' do
    before do
      create(:book)
      create(:book)
      create(:book)
      visit bestseller_path(1)
    end

    it 'displays left arrow as innactive' do
      expect(page.find('.fa-caret-left')[:class].split).to include('inactive')
    end

    it 'displays right arrow as active' do
      expect(page.find('.fa-caret-right')[:class].split).to include('active')
    end
  end

  context 'when last bestseller is displayed' do
    before do
      create(:book)
      create(:book)
      create(:book)
      visit bestseller_path(3)
    end

    it 'displays left arrow as nactive' do
      expect(page.find('.fa-caret-left')[:class].split).to include('active')
    end

    it 'displays right arrow as inactive' do
      expect(page.find('.fa-caret-right')[:class].split).to include('inactive')
    end
  end
end