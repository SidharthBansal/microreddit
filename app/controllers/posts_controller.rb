class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    if @post.save
      flash[:success] = "New Post is successfully created"
      redirect_to @post
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
