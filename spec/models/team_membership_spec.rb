require 'spec_helper'

RSpec.describe TeamMembership, model: true do
  it { should belong_to(:team) }
  it { should belong_to(:user) }
end
