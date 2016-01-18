class BestsellersController < ApplicationController

  BESTSELLERS_COUNT = 100

  def index
    redirect_to bestseller_path(1)
  end

  def show
    @bestseller = Book.bestsellers[params[:id].to_i]
    case params[:id].to_i
    when 1 then @next = 2
    when BESTSELLERS_COUNT then @previous = BESTSELLERS_COUNT - 1
    else 
      @previous = params[:id] - 1
      @next = params[:id] + 1
    end
  end
end
