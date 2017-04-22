class NewsFeedsController < ApplicationController
    def index
        @news_feeds = NewsFeed.all.order('created_at DESC')
    end
end
