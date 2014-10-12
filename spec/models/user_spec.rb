require 'spec_helper'

RSpec.describe User, model: true do
  it { should have_many(:nominations) }
  it { should have_many(:awards) }
  it { should have_many(:votes) }
  it { should belong_to(:github_team) }

  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:pic_url) }
  it { should validate_presence_of(:username) }

  it { should have_valid(:provider).when('github') }
  it { should_not have_valid(:provider).when(nil, '', 'facebook', 'twitter') }

  it { should have_valid(:role).when('user', 'admin') }
  it { should_not have_valid(:role).when('', 'other', 'godmode') }

  it 'should validate uniqueness of uid scoped to provider' do
    user = FactoryGirl.create(:user)
    second_user = FactoryGirl.build(:user, uid: user.uid, provider: user.provider)

    expect { second_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
