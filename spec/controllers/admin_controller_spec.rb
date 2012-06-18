require 'spec_helper'

describe AdminController do
  let(:user) { create :user }

  it { should route(:get, '/admin').to(:action => :show) }
  
  describe 'GET show' do
    before { get :show }

    it { should redirect_to new_user_session_path }
  end
  
  context 'User' do
    before { sign_in user }

    describe 'GET show' do
      before { get :show }

      it { should redirect_to new_user_session_path }
    end
  end
  
  context 'Admin' do
    before do
      @admin = create :user

      @admin.roles << (Role.create :title => 'admin')
    
      sign_in @admin
    end

    describe 'GET show' do
      before { get :show }

      it { should render_template :show }
    end
  end
end
