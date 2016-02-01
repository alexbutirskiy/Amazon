class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    review = Review.new(review_params)
    review.customer = current_user.customer
    @book = Book.find(params[:book_id])
    @book.reviews << review
    @book.save
    redirect_to book_path(@book)
  end

  private

  def review_params
    params.require(:review).permit(:title, :text, :value)
  end
end
