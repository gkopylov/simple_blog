require 'spec_helper'

describe Admin::UsersController do
  let(:user) { create :user }

  it { should route(:get, '/admin/users').to(:action => :index) }
  
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

    describe 'GET edit' do
      before { get :edit, :id => user }

      it { should render_template :edit }

      it { should assign_to(:user).with(user) }
    end

    describe 'PUT update' do
      context 'with valid attributes' do
        before { put :update, :id => user, :user => { :name => 'rename' } }

        it { should render_template :edit }

        it { assigns(:user).name.should == 'rename' }
      end

      context 'with invalid attributes' do
        before { put :update, :id => user, :user => { :email => '' } }

        it { should render_template :edit }
      end
    end
    
    describe 'GET show' do
      before { get :show, :id => user }

      it { should render_template :show }
    end
  end

end
