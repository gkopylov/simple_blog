require 'spec_helper'

describe Role do
  it { should belong_to :user }

  it { should validate_presence_of :title } 
end
