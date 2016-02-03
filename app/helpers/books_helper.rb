module BooksHelper
  def authors_of_book_with_links
    @bestseller_current.authors.inject('') do |out, author|
      out += ', ' unless out.empty?
      out + link_to("#{ author.name() }", author_path(author))
    end
  end

  def authors_names(authors)
    authors.inject('') do |out, a|
      out += ', ' unless out.empty?
      out + a.name
    end
  end

  def bestseller_prev_link
    if @id == 1
      content_tag(:p, '', class: 'fa fa-caret-left arrow inactive')
    else
      link_to('', bestseller_path(@id - 1), class: 'fa fa-caret-left arrow active')            
    end
  end

  def bestseller_next_link
    if @id == Book.bestsellers_max
      content_tag(:p, '', class: 'fa fa-caret-right arrow inactive')
    else
      link_to('', bestseller_path(@id + 1), class: 'fa fa-caret-right arrow active')
    end
  end

  def display_books
    
  end

  def display_stars(value)
    star_all = 5
    star_full = (value * star_all)/Review::MAX_RATING
    star_half = ((value * star_all)%Review::MAX_RATING != 0) ? 1:0
    star_empty = star_all - star_full - star_half
    out = ""

    star_full.times do
      out += content_tag('i', '', class: ['fa', 'fa-star'])
    end

    star_half.times do
      out += content_tag('i', '', class: ['fa', 'fa-star-half-o'])
    end

    star_empty.times do
      out += content_tag('i', '', class: ['fa', 'fa-star-o'])
    end

    out.html_safe
  end
end