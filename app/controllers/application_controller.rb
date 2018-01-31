class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate
  def authenticate
    # first see if they already have a session
    if (user = User.find(session[:current_user_id])
      session[:current_user_id] = user.id
      @current_user = user
    else
      if user = authenticate_with_http_basic { |u, p| User.find_by(username: u) }
        session[:current_user_id] = user.id
        @current_user = user
      else
        request_http_basic_authentication
      end
    end
  end
end
