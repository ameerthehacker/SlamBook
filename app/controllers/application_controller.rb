class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_signed_in?
        unless session[:user_id].nil?
            true
        else
            false
        end
  end
  def current_user
      @user ||= User.find(session[:user_id])
  end
  def authenticate_user!
      unless user_signed_in?
          redirect_to home_path
          false
      else
          true
      end
  end

  helper_method :user_signed_in?
  helper_method :current_user
end
