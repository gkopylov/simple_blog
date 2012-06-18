class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :roles_attributes

  validates :email, :presence => true, uniqueness: { case_sensitive: false }

  validates :password, :presence => true

  has_many :roles, :dependent => :destroy 

  has_many :posts, :dependent => :destroy
  
  has_many :comments, :dependent => :destroy

  accepts_nested_attributes_for :roles, :allow_destroy => true

  paginates_per 5
  
  def admin?
    !!roles.find_by_title('admin')
  end

  %w(user role post comment).each do |item|
    define_method "manage_all_#{item.pluralize}?" do
      !!roles.find_by_title("manage_all_#{item.pluralize}")
    end
  end

  %w(user role post comment).each do |item|
    define_method "manage_#{item}?" do |number|
      !!roles.find_by_title_and_item_id("manage_#{item}", number)
    end
  end
end
