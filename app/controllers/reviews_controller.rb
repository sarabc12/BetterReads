class ReviewsController < ApplicationController
  def index
    @reviews = policy_scope(Review)
  end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
    authorize @book
  end

  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.book = @book
    @review.date = Date.today
    authorize @review

    if @review.save
      redirect_to book_path(@book), notice: 'Review created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @book = @review.book
    @review.destroy
    redirect_to book_path(@book), notice: 'Review Deleted.'
    authorize @review
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
