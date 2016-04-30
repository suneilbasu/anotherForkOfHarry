class BlogPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    user.journalist?
  end

  def new?
    user.journalist?
  end
end
