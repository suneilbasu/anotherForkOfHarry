class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  private
      def store_location
        session[:return_to] = request.request_uri
      end
      def user_not_authorized
      	flash[:alert]= "Access Denied."
        redirect_to(session[:return_to] || root_path)

        session[:return_to] = nil
      end
end
