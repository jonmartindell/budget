class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate
  def authenticate
    if username = cookies.permanent[:current_username]
      @current_user = User.find_by(username: username)
      return
    end

    if user = authenticate_with_http_basic { |u, p| User.find_by(username: u) }
      cookies.permanent[:current_username] = user.username
      @current_user = user
    else
      request_http_basic_authentication
    end
  end
end
