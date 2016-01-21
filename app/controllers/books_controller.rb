class BooksController < ApplicationController
  def index
    @books = Book.page params[:page]
  end

  def show
    @book = Book.find(params[:id])
  end

  def show_bestseller
    @id = params[:id].to_i
    begin
      @bestseller_current = Book.bestseller(@id)
    rescue ActiveRecord::RecordNotFound
      raise if @id != 1
      render 'no_book'
    end
  end
end
