class UsersController < ApplicationController
  def dashboard
    @user = current_user
    @lists = current_user.lists
    @bookreads = current_user.bookreads.includes(:book)

    authorize current_user

    this_year = Time.current.beginning_of_year
    @books_read_this_year = current_user.lists.find_by(title: "Read").books.size
    @total_pages_read = current_user.lists.find_by(title: "Read").books.map {|book| book.book_length}.sum

    @currently_reading_count = current_user.lists.find_by(title: "Currently Reading").books.size

    @favourite_genre = current_user.books
    .joins(:bookreads)
    .where(bookreads: { status: "Finished!" })
    .group(:genre)
    .order("COUNT(books.id) DESC")
    .limit(1)
    .pluck(:genre)
    .first
  end

  def edit_bio
    @user = current_user
    authorize @user
  end

  def update_bio
    @user = current_user
    authorize @user
    if @user.update(bio_params)
      redirect_to user_dashboard_path, notice: "Bio updated successfully."
    else
      render :edit_bio, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end

  def bio_params
    params.require(:user).permit(:bio)
  end

end
