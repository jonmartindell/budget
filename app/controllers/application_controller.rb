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

    if user = user_input
      cookies.permanent[:current_username] = user.username
      @current_user = user
    else
      request_http_basic_authentication
    end
  end

  private

  def user_input
    authenticate_with_http_basic do |username,password|
      return nil unless valid_usernames.include?(username)
      User.find_or_create_by(username: username)
    end
  end

  def valid_usernames
    ENV['VALID_USERNAMES'].split(';')
  end
end
