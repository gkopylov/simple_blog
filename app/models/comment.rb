class Comment < ActiveRecord::Base
  attr_accessible :text, :user_id

  default_scope order('created_at DESC')
  
  belongs_to :user

  belongs_to :post

  validates_presence_of :text, :user_id

  attr_protected :user_id
end
