class Slam < ActiveRecord::Base
    # Validations
    validates :answers, :presence => true
    validates :privacy, :presence => true    
    # Associations
    belongs_to :book
    belongs_to :user
    has_many :news_feeds, :dependent => :destroy
    has_many :answers, :dependent => :destroy
    has_many :comments, :dependent => :destroy
    # Nested Attributes
    accepts_nested_attributes_for :answers
end
