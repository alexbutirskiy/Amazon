module BestsellersHelper

  def authors_names(authors)
    authors.inject('') do |out, a|
      out += ', ' unless out.empty?
      out += a.name
    end
  end

  # def bestseller_prev_link
  #   if @bestseller_previous_id
  #     link_to('', bestseller_path(@bestseller_previous_id), class: 'fa fa-caret-left arrow active')      
  #   else
  #     content_tag(:p, '', class: 'fa fa-caret-left arrow inactive')
  #   end
  # end

  # def bestseller_next_link
  #   if @bestseller_next_id
  #     link_to('', bestseller_path(@bestseller_next_id), class: 'fa fa-caret-right arrow active')
  #   else
  #     content_tag(:p, '', class: 'fa fa-caret-right arrow inactive')
  #   end
  # end

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