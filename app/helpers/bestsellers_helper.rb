module BestsellersHelper

  def authors_names(authors)
    authors.inject('') do |out, a|
      out += ', ' unless out.empty?
      out += a.name
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
end
