class CommentsController < InheritedResources::Base 
  include InheritedResources::DSL

  belongs_to :post, :optional => true

  load_and_authorize_resource
  
  respond_to :js

  before_filter :assign_current_user, :only => [:new, :create]

  create! do |success, failure|
    success.js { render }
  
    failure.js { render :new }    
  end 

  update! do |success, failure|
    success.js { render }
  
    failure.js { render :edit }    
  end 
  
  private
  def collection
    @comments ||= end_of_association_chain.page(params[:page])
  end

  def assign_current_user
    resource.user = current_user
  end
end
