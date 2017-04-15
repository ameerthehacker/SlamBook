class Answer < ActiveRecord::Base
    # Validations
    validates :question, :presence => true
    validates :answer, :presence => true, :length => { :minimum => 2, :maximum => 120 }   
    # Associations
    belongs_to :slam
end
