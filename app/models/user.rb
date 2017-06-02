class User < ActiveRecord::Base

    # Validations
    validates :first_name, :presence => true
    
    # Associations
    has_many :books, :dependent => :destroy
    has_many :slams, :dependent => :destroy
    has_many :news_feeds, :dependent => :destroy
    has_many :followings, :dependent => :destroy
    has_many :followers, :through => :followings
    has_many :comments, :dependent => :destroy


    def full_name
    "#{first_name} #{last_name}"
    end
    def self.from_omniauth(auth)
        where({ :provider => auth.provider, :uid => auth.uid }).first_or_initialize.tap do |user|
            new_user = user.new_record?
            user.uid = auth.uid
            user.provider = auth.provider
            user.first_name = auth.info.first_name
            user.last_name = auth.info.last_name  
            user.email = auth.info.email
            user.avatar = auth.info.image
            user.oauth_token = auth.credentials.token
            user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            user.save!
            if new_user
                User.delay.email_joined(user)
                User.delay.notify_fb_friends(user, "Your friend #{user.full_name} just now joined the slambooks", Rails.application.routes.url_helpers.user_path(user))
            end
        end
    end
    def facebook
        @facebook ||= Koala::Facebook::API.new(self.oauth_token)
    end
    def self.notify_followers(user, template, href)
        @app ||= Koala::Facebook::API.new(Koala::Facebook::OAuth.new("1898283013788070", "2aec77dd54976fd74ac7cc8641c53309").get_app_access_token)
        user.followers.each do |follower|
            @app.put_connections(follower.uid, "notifications", :template => template, :href => href)
        end
    end
    def self.notify_fb_friends(user, template, href)
        fb_users = user.facebook.get_connection("me", "friends")
        user_ids = []
        fb_users.each do | fb_user |
            user_ids << fb_user['id']
        end
        @app ||= Koala::Facebook::API.new(Koala::Facebook::OAuth.new("1898283013788070", "2aec77dd54976fd74ac7cc8641c53309").get_app_access_token)
        user_ids.each do |uid|
            @app.put_connections(uid, "notifications", :template => template, :href => href)
        end
    end
    def self.notify_user(user, template, href)
       @app ||= Koala::Facebook::API.new(Koala::Facebook::OAuth.new("1898283013788070", "2aec77dd54976fd74ac7cc8641c53309").get_app_access_token)
       @app.put_connections(user.uid, "notifications", :template => template, :href => href)
    end
    def self.email_new_book(user, book)
        user.followers.each do |follower|
            unless follower.email.blank?
                UserMailer.new_book(user, follower, book).deliver
            end
        end
    end
    def self.email_update_book(user, book)
        user.followers.each do |follower|
            unless follower.email.blank?
                UserMailer.update_book(user, follower, book).deliver                                
            end
        end
    end
    def self.email_new_slam(user, slam)
        if slam.privacy == 'PUBLIC'
            user.followers.each do |follower|
                unless follower.email.blank?
                    UserMailer.new_slam(user, follower, slam).deliver                
                end
            end
        end
        unless slam.book.user.email.blank?
            UserMailer.new_slam(user, slam.book.user, slam).deliver                
        end
    end
    def self.email_followed(user, follower)
        unless user.email.blank?
            UserMailer.follow(user, follower).deliver            
        end
    end
    def self.email_joined(user)
        user.fb_friends.each do |fb_friend|
            unless fb_friend.email.blank?
                UserMailer.new_user(user, fb_friend).deliver                
            end
        end
    end
    def fb_friends
        fb_users = self.facebook.get_connection("me", "friends")
        user_ids = []
        fb_users.each do | fb_user |
            user_ids << fb_user['id']
        end
        @users = User.where(:uid => user_ids)
    end
    def suggested_users
        max_users = 6
        @suggested_users = self.fb_friends
        @suggested_users = @suggested_users.where.not(:id => self.following_users.ids)
        no_suggested = @suggested_users.count
        needed_suggestions = max_users - no_suggested
        if needed_suggestions > 0
            User.where.not(:id => @suggested_users.ids).where.not(:id => self.following_users.ids).order('created_at DESC').limit(needed_suggestions).each do |user|
                if user != self
                    @suggested_users << user
                end
            end
        end
        @suggested_users
    end
    def following_users
        user_ids = []
        followings  = Following.where(:follower_id => self.id)
        followings.each do |following|
            user_ids << following.user_id
        end
        @users = User.where(:id => user_ids)
    end
    def news_feeds
        following_users = [] 
        followings = Following.where(:follower_id => self)
        @news_feeds = NewsFeed.where(:user_id => self.following_users.ids).order('created_at DESC')
    end
end
