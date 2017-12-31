class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "New Post is successfully created"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def index
    @posts = Post.all
  end

  def edit
  end
  def update
  end

  def destroy

  end

  private

    def post_params
      params.require(:post).permit(:title, :description)
    end
end
