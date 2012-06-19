require 'spec_helper'

describe Admin::UsersController do
  let(:user) { create :user }

  it { should route(:get, '/admin/users').to(:action => :index) }
  
  it { should route(:get, '/admin/users/1').to(:action => :show, :id => 1) }
  
  it { should route(:get, '/admin/users/1/edit').to(:action => :edit, :id => 1) }
  
  it { should route(:put, '/admin/users/1').to(:action => :update, :id => 1) }
  
  it { should route(:delete, '/admin/users/1').to(:action => :destroy, :id => 1) }
  
  describe 'GET index' do
    before { get :index }

    it { should redirect_to new_user_session_path }
  end

  describe 'GET show' do
    before { get :show, :id => user }

    it { should redirect_to new_user_session_path }
  end
  
  describe 'PUT update' do
    before { put :update, :id => user }

    it { should redirect_to new_user_session_path }
  end

  describe 'DELETE destroy' do
    before { delete :destroy, :id => user }

    it { should redirect_to new_user_session_path }
  end
  
  context 'User' do
    before { sign_in user }
  
    describe 'GET index' do
      before { get :index }

      it { should redirect_to new_user_session_path }
    end

    describe 'GET show' do
      before { get :show, :id => user }

      it { should redirect_to new_user_session_path }
    end
    
    describe 'PUT update' do
      before { put :update, :id => user }

      it { should redirect_to new_user_session_path }
    end

    describe 'DELETE destroy' do
      before { delete :destroy, :id => user }

      it { should redirect_to new_user_session_path }
    end
  end
  
  context 'Admin' do
    before do
      @admin = create :user

      @admin.roles << (Role.create :title => 'admin')
    
      sign_in @admin
    end

    describe 'GET index' do
      before { get :index }

      it { should render_template :index }

      it { should assign_to(:users) }
    end
    
    describe 'GET edit' do
      before { get :edit, :id => user }

      it { should render_template :edit }

      it { should assign_to(:user).with(user) }

      it { should assign_to(:user).with_kind_of(User) }
    end

    describe 'PUT update' do
      context 'with valid attributes' do
        before { put :update, :id => user, :user => { :name => 'rename' } }

        it { should render_template :edit }

        it { assigns(:user).name.should == 'rename' }

        it { should assign_to(:user).with_kind_of(User) }
      end

      context 'with invalid attributes' do
        before { put :update, :id => user, :user => { :email => '' } }

        it { should render_template :edit }
      end
    end
    
    describe 'GET show' do
      before { get :show, :id => user }

      it { should render_template :show }

      it { should assign_to(:user).with_kind_of(User) }
    end
  end
end
