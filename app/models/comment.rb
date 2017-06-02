class Comment < ActiveRecord::Base
    # Associations
    belongs_to :slam
    belongs_to :user
    has_many :replies, :class_name => 'Comment', :foreign_key => 'reply_to', :dependent => :destroy
    # Validations
    validates :comment, :presence => true

end
