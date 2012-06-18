class UsersController < InheritedResources::Base
  include InheritedResources::DSL
  
  actions :index, :show, :update, :edit

  update! do |success, failure|
    success.html { redirect_to @post }
  
    failure.html { render :edit }    
  end 
end
