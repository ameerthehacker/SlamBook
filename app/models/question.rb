class Question < ActiveRecord::Base
    # Validations
    validates :question, :presence => true, :length => { :minimum => 5, :maximum => 200 }
    # Associations
    belongs_to :book
end
