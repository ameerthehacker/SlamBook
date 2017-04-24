class HomeController < ApplicationController
    before_action :user_signed_in
    def index
    end
private
    def user_signed_in
        if user_signed_in?
            redirect_to news_feeds_path
        else
            true
        end
    end
end