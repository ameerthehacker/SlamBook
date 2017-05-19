class User < ActiveRecord::Base

    # Validations
    validates :first_name, :presence => true
    validates :email, :presence => true, :uniqueness => true
    
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
end
