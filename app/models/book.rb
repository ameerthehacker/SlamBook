class Book < ActiveRecord::Base
    # Validations
    validates :title, :presence => true, :length => { :minimum => 5, :maximum => 40 }
    validates :description, :presence => true, :length => { :minimum => 5, :maximum => 100 }    
    # Associations
    has_many :questions
    # Nested attributes
    accepts_nested_attributes_for :questions, :allow_destroy => true
end
