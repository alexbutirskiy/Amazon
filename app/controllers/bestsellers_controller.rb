class BestsellersController < ApplicationController

  def index
    redirect_to bestseller_path(1)
  end

  def show
    @id = params[:id].to_i
    @bestseller_current = Book.bestseller(@id)
  end
end
