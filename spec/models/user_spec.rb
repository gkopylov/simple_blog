require 'spec_helper'

describe User do
  let(:user) { create :user }

  it { should have_many(:roles).dependent(:destroy) }

  it { should have_many(:posts).dependent(:destroy) }

  it { should have_many(:comments).dependent(:destroy) }

  it { user; validate_uniqueness_of :email }

  describe '#admin?' do
    subject { user.admin? }

    describe 'when user is admin' do
      before { user.roles.create(:title => 'admin') }

      it { should == true }
    end

    describe 'when user is not admin, by default' do
      it { should == false }
    end
  end

  #TODO create spec for password and mail validations
end
