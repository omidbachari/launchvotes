require 'spec_helper'

RSpec.describe User, model: true do
  it { should have_many(:nominations) }
  it { should have_many(:awards) }
  it { should have_many(:votes) }

  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:pic_url) }

  it 'should validate uniqueness of uid scoped to provider' do
    user = FactoryGirl.create(:user)
    second_user = FactoryGirl.build(:user, uid: user.uid, provider: user.provider)

    expect { second_user.save!}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
