class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  def user_signed_in?
        unless session[:user_id].nil?
            true
        else
            false
        end
  end
  def current_user
      @current_user ||= User.find(session[:user_id])
  end
  def authenticate_user!
      unless user_signed_in?
          session[:last_url] = request.url
          redirect_to home_path
          false
      else
          true
      end
  end
  def redirect_back_or_to(url)
      redirect_to(session["last_url"]||url)
      session[:last_url] = nil
  end

  helper_method :user_signed_in?
  helper_method :current_user
  helper_method :redirect_back_or_to
end
