class Post < ActiveRecord::Base
  attr_accessible :name, :text, :user_id

  default_scope order('created_at')

  belongs_to :user

  attr_protected :user_id

  validates :text, :presence => true

  validates :name, :presence => true, :uniqueness => true

  has_many :comments, :dependent => :destroy

  paginates_per 2
end
