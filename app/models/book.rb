class Book < ActiveRecord::Base
    # Validations
    validates :title, :presence => true, :length => { :minimum => 5, :maximum => 40 }
    validates :description, :presence => true, :length => { :minimum => 5, :maximum => 100 }   
    validates :questions, :presence => true 
    # Associations
    has_many :questions, :dependent => :destroy
    has_many :slams, :dependent => :destroy 
    has_many :news_feeds, :dependent => :destroy
    belongs_to :user
    # Nested attributes
    accepts_nested_attributes_for :questions, :allow_destroy => true
    validates_associated :questions
end
