require 'spec_helper'

describe UsersController do
  it { should be_a InheritedResources::Base } 

  it { should route(:get, '/users').to(:action => :index) }

  it { should route(:get, '/users/1').to(:action => :show, :id => 1) }

  it { should route(:get, '/users/1/edit').to(:action => :edit, :id => 1) }
  
  it { should route(:put, '/users/1').to(:action => :update, :id => 1) }
  
  it { should route(:delete, '/users/1').to(:action => :destroy, :id => 1) }
end
