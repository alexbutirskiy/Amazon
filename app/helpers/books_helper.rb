module BooksHelper
  def authors_of_book_with_links
    @bestseller_current.authors.inject('') do |out, author|
      out += ', ' unless out.empty?
      out + link_to("#{ author.name() }", author_path(author))
    end
  end
end