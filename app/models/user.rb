class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :default_role

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :name, :role_ids
  
  has_many :articles
  has_and_belongs_to_many :roles
  
  validates :first_name, :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true

  
  def name
    self.first_name + " " + self.last_name
  end


  def editor_role
    self.role_ids = [2]
  end
  
  def admin_role
    self.role_ids = [1]
  end
  
  def regular?
    self.role? :regular
  end
  
  def admin? 
    self.role? :super_admin
  end
  
  def user_admin?
    self.role? :super_admin
  end
  

  def default_role
    self.role_ids = [3] unless self.roles.size > 0
  end



  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  
end
