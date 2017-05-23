class User < ActiveRecord::Base

    # Validations
    validates :first_name, :presence => true
    
    # Associations
    has_many :books, :dependent => :destroy
    has_many :slams, :dependent => :destroy
    has_many :news_feeds, :dependent => :destroy
    has_many :followings, :dependent => :destroy
    has_many :followers, :through => :followings


    def full_name
    "#{first_name} #{last_name}"
    end
    def self.from_omniauth(auth)
        where({ :provider => auth.provider, :uid => auth.uid }).first_or_initialize.tap do |user|
            user.uid = auth.uid
            user.provider = auth.provider
            user.first_name = auth.info.first_name
            user.last_name = auth.info.last_name  
            user.email = auth.info.email
            user.avatar = auth.info.image
            user.oauth_token = auth.credentials.token
            user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            user.save!
        end
    end
    def facebook
        @facebook ||= Koala::Facebook::API.new(oauth_token)
    end
    def self.notify_followers(template, href)
        @app ||= Koala::Facebook::API.new(Koala::Facebook::OAuth.new("1898283013788070", "2aec77dd54976fd74ac7cc8641c53309").get_app_access_token)
        self.followers.each do |follower|
            @app.put_connections(follower.uid, "notifications", :template => template, :href => href)
        end
    end
    def self.notify_user(user, template, href)
       @app ||= Koala::Facebook::API.new(Koala::Facebook::OAuth.new("1898283013788070", "2aec77dd54976fd74ac7cc8641c53309").get_app_access_token)
       @app.put_connections(user.uid, "notifications", :template => template, :href => href)
    end
    def self.email_followed(user, follower)
        UserMailer.follow(user, follower).deliver
    end
end
