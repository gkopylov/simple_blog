class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path 
  end

  protected
  def current_ability
    @current_ability ||= Rails.cache.fetch("current_ability_#{current_user.try(:id)}") do
      Ability.new(current_user)
    end
  end 
end
