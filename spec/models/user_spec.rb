require 'spec_helper'

RSpec.describe User, model: true do
  it { should have_many(:nominations) }
  it { should have_many(:awards) }
  it { should have_many(:votes) }
  it { should have_many(:team_memberships) }

  it { should validate_presence_of(:username) }

  it { should have_valid(:provider).when('github') }
  it { should_not have_valid(:provider).when(nil, '', 'facebook', 'twitter') }

  it { should have_valid(:role).when('user', 'admin') }
  it { should_not have_valid(:role).when('', 'other', 'godmode') }
end
