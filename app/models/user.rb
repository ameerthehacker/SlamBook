class User < ActiveRecord::Base
  # Uploader for user avatar
  mount_uploader :avatar, AvatarUploader

  # Validations
  validates :first_name, :presence => true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :avatar, file_size: { less_than_or_equal_to: 1.megabytes },
                     file_content_type: { allow: ['image/jpeg', 'image/png'] }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
  # Associations
  has_many :books, :dependent => :destroy
  has_many :slams, :dependent => :destroy
  has_many :news_feeds, :dependent => :destroy
  has_many :followings, :dependent => :destroy
  has_many :followers, :through => :followings
end
