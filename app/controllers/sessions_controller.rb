class SessionsController < ApplicationController
    def create
        user = User.from_omniauth(env["omniauth.auth"])
        session[:user_id] = user.id
        redirect_back_or_to home_path                 
    end
    def destroy
        session[:user_id] = nil
        session[:last_url] = nil
        redirect_to home_path          
    end
    def failure
    end
end
