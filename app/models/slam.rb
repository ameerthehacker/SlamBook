class Slam < ActiveRecord::Base
    # Validations
    validates :answers, :presence => true
    validates :privacy, :presence => true    
    # Associations
    belongs_to :book
    belongs_to :user
    has_many :answers
    # Nested Attributes
    accepts_nested_attributes_for :answers
end
