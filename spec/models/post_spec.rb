require 'spec_helper'

describe Post do
  let(:post) { create :post }

  it { should belong_to :user }

  it { should have_many(:comments).dependent(:destroy) }

  it { should validate_presence_of :name }
  
  it { post; should validate_uniqueness_of :name }

  it { should validate_presence_of :text } 

  it { should_not allow_mass_assignment_of :user_id } 
end
