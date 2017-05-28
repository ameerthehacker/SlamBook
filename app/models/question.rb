class Question < ActiveRecord::Base
    # Validations
    validates :question, :presence => true, :length => { :minimum => 5, :maximum => 200 }
    # Associations
    belongs_to :book
    has_many :question_options, :dependent => :destroy
    # Nested attributes
    accepts_nested_attributes_for :question_options, :allow_destroy => true, :update_only => true
    validates_associated :question_options
    validate :options_present
private
    def options_present
        unless question_type == 'textarea' 
            if question_options.empty?
                errors.add(:option, "can't be empty")
                false
            end
            if question_options.size < 2
                errors.add(:question, "must have atleast two options")  
                false              
            end
            question_options.each do |option|
                if option.option.blank?
                    errors.add(:option, "can't be blank")
                    false                        
                    break
                end
            end
            true
        else
            question_options.destroy_all
            true
        end
    end
end
