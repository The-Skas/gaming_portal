class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  #Eh... apparently dont put this if its on web.
  skip_before_filter  :verify_authenticity_token

  private
  def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this site"
        redirect_to root_url
      end
  end

  def catch_exceptions
    yield
  rescue=>exception
      logger.debug 'Caught and Exception'
  end

  def logged_in?
    !!current_user
  end
end
