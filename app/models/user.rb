class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  attr_accessible :name

  validates :email, :presence => true, uniqueness: { case_sensitive: false }

  validates :password, :presence => true

  has_many :roles

  has_many :posts
  
  has_many :comments

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
  
  def edit_all?
    !!roles.find_by_title('admin')
  end
end
