class BooksController < ApplicationController
  def index
    @category = Category.find(params[:category]) if params[:category]

    if @category
      @books = Book.where(category: @category.id).page params[:page]
    else
      @books = Book.page params[:page]
    end
    @categories = Category.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def show_bestseller
    id = params[:id].to_i
    begin
      @bestseller = Bestseller.new(id)
    rescue ActiveRecord::RecordNotFound
      raise if id != 1
      render 'no_book'
    end
  end
end
