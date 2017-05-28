class Answer < ActiveRecord::Base
    # Validations
    validates :question, :presence => true
    validates :answer, :presence => true, :length => { :minimum => 2, :maximum => 120 }  
    # Associations
    belongs_to :slam
    has_many :answer_options, :dependent => :destroy
    accepts_nested_attributes_for :answer_options

    def answer_radio=(option)
        self.answer = option
    end
    def answer_radio
        self.answer
    end
    def answer_checkbox=(options)
        self.answer = options.length > 0 ? options.join(", ") : nil
    end
    def answer_checkbox
        self.answer.nil? ? [] : answer.split(", ")
    end
end
