require 'spec_helper'

describe Role do
  it { should belong_to :user }
end
