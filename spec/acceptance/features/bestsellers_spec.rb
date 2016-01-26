require 'rails_helper'
require 'acceptance/features/features_spec_helper'

feature "Bestsellers" do
  context 'when DB is empty' do
    scenario "Shows 'There is no books in the Store'" do
      visit "/books/bestsellers/1"
      expect(page).to have_content('There is no books in the Store')
    end
  end

  context 'when DB has book data' do
    before do
      @book = create(:book)
    end

    scenario 'Book title is displayed' do
      visit bestseller_path(1)
      expect(page).to have_content(@book.title)
    end

    scenario "Book authors' links are displayed" do
      visit bestseller_path(1)
      @book.authors.each do |author|
        expect(page).to have_link("#{author.name}", href: "/authors/#{author.id}")
      end
    end

    scenario 'Book description is displayed' do
      visit bestseller_path(1)
      expect(page).to have_content(@book.description)
    end

    scenario 'Book price is displayed' do
      visit bestseller_path(1)
      expect(page).to have_content(@book.price)
    end

    # context "on 'books/bestsellers/1' url" do
    #   before do
    #     create(:book, sold: 1)
    #     create(:book, sold: 2)
    #     create(:book, sold: 3)
    #   end
    #   scenario "Shows the best-selling book" do
    #     vivsit "/books/bestsellers/1"
    #     expect()
    #   end
    # end
  end
end