class NewsFeedsController < ApplicationController
    def index
        @news_feeds = current_user.news_feeds.paginate(:page => params[:page], :per_page => 10)
        if @news_feeds.count == 0
            @news_feeds = NewsFeed.paginate(:page => params[:page], :per_page => 10).where(:user_id => current_user.fb_friends.ids).order("created_at DESC")
        else
            @news_feeds
        end
    end
end
