class BestsellersController < ApplicationController

  def index
    redirect_to bestseller_path(1)
  end

  def show
    @id = params[:id].to_i

    @bestseller_current = Book.bestseller(@id)
    # case id
    # when 1
    #   @bestseller_next_id = 2
    # when BESTSELLERS_COUNT
    #   @bestseller_previous_id = BESTSELLERS_COUNT - 1
    # else
    #   @bestseller_previous_id = id - 1
    #   @bestseller_next_id = id + 1
    # end
  end
end
