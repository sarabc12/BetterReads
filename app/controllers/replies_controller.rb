class RepliesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @reply = Reply.create(reply_params)
    @reply.post = @post
    @reply.user = current_user
    authorize @reply

    if @reply.save
      redirect_to book_path(@post.book), notice: "Reply added successfully."
    else
      render :new, status: :unprocessable_entity #'posts/show'
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    @post = @reply.post
    @reply.destroy
    redirect_to post_path(@post.book), notice: "Reply deleted successfully."
    authorize @reply
  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
end
