require 'spec_helper'

describe Comment do
  it { should belong_to :user }

  it { should validate_presence_of :text }

  it { should validate_presence_of :user_id }

  it { should_not allow_mass_assignment_of :user_id }
end
