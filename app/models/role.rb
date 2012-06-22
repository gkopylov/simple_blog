class Role < ActiveRecord::Base
  attr_accessible :item_id, :title, :user_id

  belongs_to :user

  validates :title, :presence => true

  after_commit :clean_role_cache

  private
  def clean_role_cache
    Rails.cache.delete("current_ability_#{self.user_id}")
  end
end
