class Question < ActiveRecord::Base
    # Validations
    validates :question, :presence => true, :length => { :minimum => 5, :maximum => 40 }
    # Associations
    belongs_to :book
end
