class UsersController < ApplicationController
  def dashboard
    @lists = current_user.lists
    @bookreads = current_user.bookreads.includes(:book)

    authorize current_user

    this_year = Time.current.beginning_of_year

    @books_read_this_year = @bookreads
      .where(status: "Finished!")
      .where("end_date >= ?", this_year)
      .count

    @total_pages_read = @bookreads
      .where(status: "Finished!")
      .includes(:book)
      .map { |br| br.book&.book_length.to_i }
      .sum

    @currently_reading_count = @bookreads
      .where(status: "currently reading")
      .count

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

  def bio_params
    params.require(:user).permit(:bio)
  end

end
