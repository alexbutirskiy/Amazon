class BooksController < ApplicationController
  def index
  end

  def show
    @book = Book.find(params[:id])
  end

  def show_bestseller
    @id = params[:id].to_i
    @bestseller_current = Book.bestseller(@id)
  end
end
