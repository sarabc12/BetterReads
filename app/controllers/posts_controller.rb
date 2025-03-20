class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = policy_scope(Post)
    @book = Book.find(params[:book_id])
  end

  def show
    @post = Post.find(params[:id])
    @replies = @post.replies
    @reply = Reply.new
    authorize @post
  end

  def new
    @book = Book.find(params[:book_id])
    @post = Post.new
    authorize @post
  end

  def create
    @book = Book.find(params[:book_id])
    @post = Post.new(post_params)
    @post.user = current_user
    @post.book = @book
    authorize @post

    if @post.save
      redirect_to book_path(@book), notice: "Post created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    @book = @post.book
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update(post_params)
      redirect_to book_posts_path(@post), notice: 'Post updated successfully.'
    else
      Rails.logger.debug(@post.errors.full_messages)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @book = @post.book
    @post.destroy
    redirect_to book_path(@book), notice: "Post deleted successfully."
    authorize @post
  end

  private

  def post_params
    params.require(:post).permit(:content, :book_id)
  end
end
