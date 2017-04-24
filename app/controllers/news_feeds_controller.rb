class NewsFeedsController < ApplicationController
    def index
        following_users = [] 
        followings = Following.where(:follower_id => current_user)
        followings.each do | following_user |
            following_users << following_user.user
        end

        @news_feeds = NewsFeed.where(:user_id => following_users).order('created_at DESC')
    end
end
