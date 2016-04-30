class BlogsController < ApplicationController
before_action :authenticate_user!
  def index

    if params[:blog] and params[:blog][:user_id]
      @blogs = Blog.search(params[:blog][:user_id])
    else
      @blogs = Blog.all
      @published_blogs = Blog.published
      @redrafted_blogs = Blog.redraft
      @rejected_blogs = Blog.rejected
      @underreview_blogs = Blog.underreview
      @unread_blogs = Blog.unread
    end
    authorize User
  end

  def new
    @blog = Blog.new
    authorize User
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def update
    @blog =Blog.find(params[:id])

    if @blog.update_attributes(blog_params)
      redirect_to root_path, :notice => "good"
    else
      redirect_to root_path, :alert => "bad"
    end
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to :action => 'index'
    else
      render(:action => 'new')
    end
  end

  def blog_params
    params.require(:blog).permit(:bodyText, :Money, :fee, :user_id, :flag)
  end
end
