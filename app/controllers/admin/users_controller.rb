class Admin::UsersController < AdminController
  include InheritedResources::DSL

  inherit_resources

  actions :all, :except => [:new, :create]
  
  update! do |success, failure|
    success.html { redirect_to [:admin, :users] }
  
    failure.html { render  }    
  end 
end
