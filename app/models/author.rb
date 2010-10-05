class Author < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :name
  has_many :articles
  
  validates :first_name, :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true

  def name
    self.first_name + " " + self.last_name
  end
end
