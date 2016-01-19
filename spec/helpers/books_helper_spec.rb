require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BooksHelper. For example:
#
# describe BooksHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BooksHelper, type: :helper do

  describe '#authors_of_book_with_links' do
    before do
      @bestseller_current = create(:book)
      @author_1 = create(:author)
      @bestseller_current.authors << @author_1
    end
    context 'when book has one author' do
      it 'returns link with author name' do
        expect(authors_of_book_with_links).to match(/#{@author_1.id}/)
        expect(authors_of_book_with_links).to match(/#{@author_1.name}/)
      end
    end

    context 'when book has two authors' do
      it 'returns link with author name' do
        @author_2 = create(:author)
        @bestseller_current.authors << @author_2
        expect(authors_of_book_with_links).to match(/#{@author_1.id}/)
        expect(authors_of_book_with_links).to match(/#{@author_2.id}/)
        expect(authors_of_book_with_links).to match(/#{@author_1.name}/)
        expect(authors_of_book_with_links).to match(/#{@author_2.name}/)
      end
    end
  end
end
