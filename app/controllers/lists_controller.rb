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
    authorize @list
    @list.save
    if @list.save
      redirect_to lists_path
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
    @list.books << @book unless @list.books.include?(@book)


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
    @list.books.delete(@book)

    redirect_to user_dashboard_path, notice: "#{@book.title} removed from #{@list.title}."
  end

  private

  def list_params
    params.require(:list).permit(:title, :description, :date)
  end

end
