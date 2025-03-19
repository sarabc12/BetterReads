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
    @list.destroy
    authorize @list
    redirect_to lists_path, status: :see_other
  end


  private

  def list_params
    params.require(:list).permit(:title, :description, :date)
  end

end
