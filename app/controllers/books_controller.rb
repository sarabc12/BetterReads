class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :show]

  def index
    @books = policy_scope(Book)
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
    @review = Review.new
    if current_user
      @lists = current_user.list
    else
      @lists = []
    end
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
