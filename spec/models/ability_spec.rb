require 'spec_helper'

describe Ability do
  let(:user) { create(:user) }

  describe 'Admin' do
    subject { Ability.new(user) }

    before { user.roles.create(:title => 'admin') }

    it { should be_able_to(:manage, :all) }
  end
  
  %w(user role post comment).each do |resource|
    describe "User manage_all_#{resource.pluralize}" do
      before do
        @user = create :user

        @user.roles << (Role.create :title => "manage_all_#{resource.pluralize}")
      end

      subject { Ability.new(@user) }
      
      it { should be_able_to :manage, resource.classify.constantize }
    end
  end

  %w(user role post comment).each do |resource|
    describe "User manage_#{resource}" do
      before do
        @item = create resource.to_sym

        @user = create :user

        @user.roles << (Role.create :title => "manage_#{resource}", :item_id => @item.id )
      end

      subject { Ability.new(@user) }
      
      it { should be_able_to :manage, @item }
    end
  end

  describe 'User' do
    subject { Ability.new(user) }

    it { should be_able_to :create, Post }

    it { should be_able_to :manage, create(:post, :user => user) }

    it { should_not be_able_to :manage, create(:post) }

    it { should be_able_to :create, Comment }

    it { should be_able_to :manage, create(:comment, :user => user) }

    it { should_not be_able_to :manage, create(:comment) }

    it { should be_able_to :edit, user }
    
    it { should_not be_able_to :manage, create(:role) }

    it { should_not be_able_to :create, Role }

    it { should_not be_able_to :update, Role }

    it { should_not be_able_to :destroy, Role }
  end

  context 'Anonymous' do
    subject { Ability.new(nil) }
    
    it { should be_able_to(:read, create(:post)) }

    it { should be_able_to(:read, create(:comment)) }
    
    it { should_not be_able_to :manage, create(:post) }

    it { should_not be_able_to :manage, create(:comment) }

    it { should_not be_able_to :manage, create(:user) }

    it { should_not be_able_to :manage, create(:role) }

    it { should be_able_to :read, Comment }

    it { should be_able_to :read, Post }

    it { should be_able_to :read, User }

    it { should be_able_to :read, Role }

    it { should_not be_able_to :create, Post }

    it { should_not be_able_to :create, Comment }
    
    it { should_not be_able_to :create, Role }

    it { should_not be_able_to :destroy, Post }

    it { should_not be_able_to :destroy, Comment }
    
    it { should_not be_able_to :destroy, Role }

    it { should_not be_able_to :update, Post }

    it { should_not be_able_to :update, Comment }
    
    it { should_not be_able_to :update, Role }
  end
end
