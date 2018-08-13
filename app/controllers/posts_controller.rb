class PostsController < ApplicationController
  before_action :require_login
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    puts(@post.user_id)
    if @post.save
      puts("Post saved")
    end
    
  end
  
  private
  
    def post_params
      params.require(:post).permit(:title,:body)
    end
  
    def require_login
      if logged_in?
        flash[:success] = "User Logged in"
      else
        flash[:danger] = "Please Log in"
        redirect_to login_path
      end
    end
  
end
