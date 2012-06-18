class PostsController < InheritedResources::Base
  include InheritedResources::DSL

  load_and_authorize_resource

  has_scope :page, :default => 1

  before_filter :assign_current_user, :only => [:new, :create]

  create! do |success, failure|
    success.html { redirect_to @post }
  
    failure.html { render :new }    
  end 

  update! do |success, failure|
    success.html { redirect_to @post }
  
    failure.html { render :edit }    
  end 
  
  private
  def collection
    @posts ||= end_of_association_chain.page(params[:page])
  end

  def assign_current_user
    resource.user = current_user
  end
end
