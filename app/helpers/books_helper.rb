module BooksHelper
  def authors_names(authors)
    authors.inject('') do |out, a|
      out += ', ' unless out.empty?
      out += a.name
    end
  end
end
