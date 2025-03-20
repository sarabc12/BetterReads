class BooksController < ApplicationController
  def index
    @books = policy_scope(Book)
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
    @review = Review.new
    @lists = current_user.lists
    authorize @book
  end

  def search
    authorize Book

    if params[:query].present?
      @books = policy_scope(Book).where("title ILIKE ? OR author ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @books = policy_scope(Book)
    end
  end
end
