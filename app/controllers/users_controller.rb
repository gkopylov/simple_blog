class UsersController < InheritedResources::Base
  include InheritedResources::DSL
  
  load_and_authorize_resource
  
  actions :index, :show, :update, :edit

  update! do |success, failure|
    success.html { redirect_to resource }
  
    failure.html { render }    
  end 
end
