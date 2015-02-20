require 'spec_helper'

RSpec.describe Team, model: true do
  it { should have_many(:team_memberships) }
  it { should have_many(:users) }
  it { should validate_presence_of(:name) }
end
