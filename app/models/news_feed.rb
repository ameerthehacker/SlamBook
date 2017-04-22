class NewsFeed < ActiveRecord::Base
    belongs_to :user
    belongs_to :book
    belongs_to :slam
end
