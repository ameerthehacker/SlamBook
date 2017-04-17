class User < ActiveRecord::Base
  # Validations
  validates :first_name, :presence => true
  validates :last_name, :presence => true  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
  # Associations
  has_many :books
  has_many :slams
end
