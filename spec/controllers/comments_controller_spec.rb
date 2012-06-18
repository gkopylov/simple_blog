require 'spec_helper'

describe CommentsController do
  it { should be_a InheritedResources::Base }

  it { should route(:get, '/posts/1/comments/new').to(:action => :new, :post_id => '1') }

  it { should route(:post, '/posts/1/comments').to(:action => :create, :post_id => 1) }
  
  it { should route(:get, '/comments/1').to(:action => :show, :id => 1) }
  
  it { should route(:get, '/comments/1/edit').to(:action => :edit, :id => 1) }
  
  it { should route(:put, '/comments/1').to(:action => :update, :id => 1) }
  
  it { should route(:delete, '/comments/1').to(:action => :destroy, :id => 1) }

  let(:post_instance) { create :post }

  let(:comment) { create :comment }

  describe 'GET new with post' do
    before { get :new, :post_id => post_instance }

    it { should redirect_to new_user_session_path }
  end

  describe 'POST create' do
    before { post :create, :post_id => post_instance, :comment => { :text => 'test' } }

    it { should redirect_to new_user_session_path }
  end

  describe 'PUT update' do
    before { put :update, :id => comment }

    it { should redirect_to new_user_session_path }
  end

  describe 'DELETE destroy' do
    before { delete :destroy, :id => comment }

    it { should redirect_to new_user_session_path }
  end
  
  describe 'GET show as JS' do
    before { get :show, :id => comment, :format => :js }

    it { should render_template :show }
    
    it { should respond_with_content_type :js }

    it { should assign_to(:comment).with(comment) }

    it { should assign_to(:comment).with_kind_of(Comment) }
  end
  
  context 'User' do
    before { sign_in comment.user }

    describe 'GET new with post as JS' do
      before { get :new, :post_id => post_instance, :format => :js }

      it { should render_template :new }

      it { should respond_with_content_type :js }

      it { should assign_to(:comment).with_kind_of(Comment) }

      it { assigns(:comment).post.should == post_instance }
    end

    describe 'POST create with post as JS' do
      before { post :create, :post_id => post_instance, :comment => { :text => 'success' }, :format => :js }

      it { should render_template :create }

      it { should respond_with_content_type :js }

      it { should assign_to(:comment).with_kind_of(Comment) }

      it { assigns(:comment).should be_persisted }

      it { assigns(:comment).user.should == controller.current_user }

      it { assigns(:comment).post.should == post_instance }
    end

    describe 'POST create as JS with invalid attributes' do
      before { post :create, :post_id => post_instance, :format => :js }

      it { should render_template :new }

      it { should respond_with_content_type :js }
    end

    describe 'GET edit as JS' do
      before { get :edit, :id => comment, :format => :js }

      it { should render_template :edit }

      it { should respond_with_content_type :js }

      it { should assign_to(:comment).with(comment) }

      it { should assign_to(:comment).with_kind_of(Comment) }
    end

    describe 'PUT update as JS' do
      before { put :update, :id => comment, :format => :js }

      it { should render_template :update }

      it { should respond_with_content_type :js }

      it { should assign_to(:comment).with(comment) }

      it { assigns(:comment).user.should == controller.current_user }

      it { should assign_to(:comment).with_kind_of(Comment) }
    end

    describe 'PUT update as JS with invalid attributes' do
      before { put :update, :id => comment, :comment => { :text => '' }, :format => :js }

      it { should render_template :edit }

      it { should respond_with_content_type :js }
    end

    describe 'DELETE destroy as JS' do
      before { delete :destroy, :id => comment, :format => :js }

      it { should render_template :destroy }

      it { should respond_with_content_type :js }
    end
  end
end
