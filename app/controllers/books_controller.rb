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
      @lists = current_user.lists
    else
      @lists = []
    end
    authorize @book
  end

  def search
    authorize Book

    @books = policy_scope(Book)

    if params[:query].present?
      @books = @books.where("title ILIKE :q OR author ILIKE :q", q: "%#{params[:query]}%")
    end

    if params[:genre].present?
      @books = @books.where("genre ILIKE ?", "%#{params[:genre]}%")
    end
  end
end
