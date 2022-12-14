class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.includes(:author, :comments, :likes).where(author_id: params[:user_id]).order(created_at: :desc)
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
    @params = params
  end

  def create
    @post = Post.new(posts_params)
    @author = current_user.id
    if @post.save
      redirect_to user_posts_path(id: @post.id, author_id: @author, comments_counter: @post.comments_counter,
                                  likes_counter: @post.likes_counter)
    else
      render :new, status: :unprocessable_entity, content_type: 'text/html'
      headers['Content-Type'] = 'text/html'
    end
  end

  private

  def posts_params
    params.require(:post).permit(:author_id, :title, :text, :comments_counter, :likes_counter)
  end
end
