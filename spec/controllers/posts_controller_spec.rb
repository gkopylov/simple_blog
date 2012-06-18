require 'spec_helper'

describe PostsController do
  it { should be_a InheritedResources::Base }
  
  it { should route(:get, '/posts').to(:action => :index) }
  
  it { should route(:get, '/posts/new').to(:action => :new) }

  it { should route(:post, '/posts').to(:action => :create) }
  
  it { should route(:get, '/posts/1').to(:action => :show, :id => 1) }
  
  it { should route(:get, '/posts/1/edit').to(:action => :edit, :id => 1) }
  
  it { should route(:put, '/posts/1').to(:action => :update, :id => 1) }
  
  it { should route(:delete, '/posts/1').to(:action => :destroy, :id => 1) }

  let(:post_instance) { create :post }

  describe 'GET index' do
    before { get :index }

    it { should render_template :index }

    it { should assign_to :posts }
  end

  describe 'GET show' do
    before { get :show, :id => post_instance }

    it { should render_template :show }

    it { should assign_to(:post).with(post_instance) }
  end
  
  describe 'GET new' do
    before { get :new }

    it { should redirect_to new_user_session_path }
  end

  describe 'POST create' do
    before { post :create }

    it { should redirect_to new_user_session_path }
  end

  describe 'PUT update' do
    before { put :update, :id => post_instance }

    it { should redirect_to new_user_session_path }
  end

  describe 'DELETE destroy' do
    before { delete :destroy, :id => post_instance }

    it { should redirect_to new_user_session_path }
  end

  context 'User' do
    before { sign_in post_instance.user }

    describe 'GET new' do
      before { get :new }

      it { should render_template :new }

      it { should assign_to(:post).with_kind_of(Post) }
    end

    describe 'POST create' do
      context 'with valid attributes' do
        before { post :create, :post => attributes_for(:post) }

        it { should redirect_to assigns(:post) }

        it { assigns(:post).user.should == controller.current_user }
      end

      context 'with invalid attributes' do
        before { post :create }

        it { should render_template :new }
      end
    end

    describe 'GET edit' do
      before { get :edit, :id => post_instance }

      it { should render_template :edit }

      it { should assign_to(:post).with(post_instance) }
    end

    describe 'PUT update' do
      context 'with valid attributes' do
        before { put :update, :id => post_instance, :post => { :name => 'rename' } }

        it { should redirect_to assigns(:post) }

        it { assigns(:post).name.should == 'rename' }
      end

      context 'with invalid attributes' do
        before { put :update, :id => post_instance, :post => { :name => '' } }

        it { should render_template :edit }
      end
    end
  end
end
