class BlogsController < ApplicationController
before_action :authenticate_user!

  def index
    @blogs = Blog.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 4)
    @published_blogs = Blog.published
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
      redirect_to root_path, :notice => "article added"
    else
      render(:action => 'new')
    end
  end

  def blog_params
    params.require(:blog).permit(:bodyText, :Money, :fee, :user_id, :flag)
  end

  private
  def sort_column
    params[:sort] || "bodyText"
  end
  def sort_direction
    params[:direction] || "asc"
 end
end
