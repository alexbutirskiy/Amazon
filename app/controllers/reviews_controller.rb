class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.customer
      @book = Book.find(params[:book_id])
      @review = Review.new
    else
      redirect_to(edit_user_customer_path(current_user), 
        alert: 'Register your name first')
    end
  end

  def create
    review = Review.new(review_params)
    review.customer = current_user.customer
    @book = Book.find(params[:book_id])

    if @book.reviews << review
      redirect_to(book_path(@book), notice: 'Review has been cerated')
    else
      display_flash(review)
      @review = review
      render(:new)
    end
  end

  private

  def review_params
    out = params.require(:review).permit(:title, :text, :value)
    out.update(value: out[:value].to_i)
  end
end
