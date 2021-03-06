class BlogsController < ApplicationController
before_action :authenticate_user!

  def index
    @blogs = Blog.where(nil)
    @blogs = @blogs.status(params[:flag]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 4) if params[:flag].present?
    @blogs = @blogs.keyword(params[:keyword]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 4) if params[:keyword].present?
    @blogs = @blogs.author(params[:author]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 4) if params[:author].present?
    if params[:blog] and params[:blog][:user_id]
      @blogs = @blogs.blog(params[:blog][:user_id]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 4) if params[:blog][:user_id].present?
    end
    authorize User

  end
  def status
    @blogs = Blog.published.paginate(:page => params[:page], :per_page => 4)
  end
  def redraft
    @blogs = Blog.redraft
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
