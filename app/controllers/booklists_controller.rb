class BooklistsController < ApplicationController

  def create
    @list = List.find(booklist_params[:list_id])
    @book = Book.find(booklist_params[:book_id])
    @booklist = Booklist.new(list: @list, book: @book)
    authorize @booklist
    if @booklist.save
      redirect_to book_path(@book), notice: "Book added successfully!"
    else
      redirect_to book_path(@book), alert: "Book not added to the list!"
    end
  end

  def destroy
    @booklist = Booklist.find(params[:id])
    if @booklist
      authorize @booklist
      @booklist.destroy
      redirect_to list_path(@booklist.list), notice: "Book removed from the list"
    else
      redirect_to list_path(@booklist.list), alert: "Book not found in this list"
    end
  end

  private

  def booklist_params
    params.permit(:list_id, :book_id)
  end

end
