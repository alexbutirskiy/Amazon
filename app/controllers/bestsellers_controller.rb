class BestsellersController < ApplicationController

  BESTSELLERS_COUNT = 5

  def index
    redirect_to bestseller_path(1)
  end

  def show
    bestsellers = Book.bestsellers.limit(BESTSELLERS_COUNT)
    @bestseller_current = bestsellers[params[:id].to_i - 1]
    case params[:id].to_i
    when 1
      @bestseller_next_id = 2
    when BESTSELLERS_COUNT
      @bestseller_previous_id = BESTSELLERS_COUNT - 1
    else 
      @bestseller_previous_id = params[:id].to_i - 1
      @bestseller_next_id = params[:id].to_i + 1
    end
  end
end
