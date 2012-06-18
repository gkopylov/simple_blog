require 'spec_helper'

describe Ability do
  let(:user) { create(:user) }

  describe 'Admin' do
    subject { Ability.new(user) }

    before { user.roles.create(:title => 'admin') }

    it { should be_able_to(:manage, :all) }
  end
  
  describe 'User' do
    subject { Ability.new(user) }

    it { should be_able_to :create, Post }

    it { should be_able_to :manage, create(:post, :user => user) }

    it { should_not be_able_to :manage, create(:post) }

    it { should be_able_to :create, Comment }

    it { should be_able_to :manage, create(:comment, :user => user) }

    it { should_not be_able_to :manage, create(:comment) }
  end
    
  context 'Anonymous' do
    subject { Ability.new(nil) }
    
    it { should be_able_to(:read, create(:post)) }

    it { should be_able_to(:read, create(:comment)) }
    
    it { should_not be_able_to :manage, Post }

    it { should_not be_able_to :manage, Comment }
  end
end
