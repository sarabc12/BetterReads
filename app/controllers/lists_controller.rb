class ListsController < ApplicationController
  def index
    @lists = policy_scope(List)
  end

  def show
    @list = List.find(params[:id])
    @books = @list.books.includes(:booklists)
    @booklists = @list.booklists
    authorize @list
  end

  def new
    @list = List.new
    authorize @list
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    @list.date ||= Time.current
    authorize @list

    if @list.save
      redirect_back fallback_location: lists_path, notice: "List created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    authorize @list

    if ["Want to Read", "Currently Reading", "Read"].include?(@list.title)
      flash[:alert] = "You cannot delete this list."
      redirect_to lists_path
      return
    end

    @list.destroy
    redirect_to lists_path, status: :see_other
  end

  def add_book
    @list = current_user.lists.find(params[:id])
    @book = Book.find(params[:book_id])
    authorize @list

    unless @list.books.include?(@book)
      @list.books << @book
    end

    if @list.title == "Currently Reading"
      bookread = current_user.bookreads.find_or_initialize_by(book: @book)
      bookread.status = "currently reading"
      bookread.book_length ||= @book.book_length
      bookread.save!
    end

    redirect_to user_dashboard_path, notice: "#{@book.title} added to #{@list.title}!"
  end

  def remove_book
    @list = current_user.lists.find(params[:id])
    @book = Book.find(params[:book_id])
    authorize @list

    @list.books.delete(@book)
    redirect_to user_dashboard_path, notice: "#{@book.title} removed from #{@list.title}."
  end

  def move_to_read
    @list = List.find(params[:id])
    @book = Book.find(params[:book_id])
    @currently_reading_list = current_user.lists.find_by(title: "Currently Reading")
    @read_list = current_user.lists.find_by(title: "Read")

    authorize @currently_reading_list

    if @currently_reading_list && @read_list
      if @currently_reading_list.books.include?(@book)
        @currently_reading_list.books.delete(@book)
      end

      unless @read_list.books.include?(@book)
        @read_list.books << @book
      end

      flash[:notice] = "#{@book.title} has been moved to 'Read'."
    else
      flash[:alert] = "Something went wrong. Please try again."
    end

    redirect_to user_dashboard_path
  end

  private

  def list_params
    params.require(:list).permit(:title, :description, :date)
  end
end
