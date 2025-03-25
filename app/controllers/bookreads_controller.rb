class BookreadsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @bookread = current_user.bookreads.find_or_initialize_by(book: @book)
    authorize @bookread

    @bookread.status = "currently reading"
    @bookread.current_page ||= 0

    if @bookread.save
      redirect_to user_dashboard_path, notice: "Tracking started for #{@book.title}!"
    else
      redirect_to user_dashboard_path, alert: "Error tracking progress."
    end
  end

  def edit
    @bookread = current_user.bookreads.find(params[:id])
    authorize @bookread
  end

  def update
    @bookread = current_user.bookreads.find(params[:id])
    authorize @bookread

    if @bookread.update(bookread_params)
      redirect_to user_dashboard_path, notice: "Reading progress updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def bookread_params
    params.require(:bookread).permit(:status, :current_page, :start_date, :end_date)
  end
end
