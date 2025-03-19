class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
    @lists = current_user.lists
    authorize @book
  end

  def search
  end
end
