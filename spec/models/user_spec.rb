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

  describe "#display_image" do
    it "uses their image if not default gravatar" do
      user = FactoryGirl.create(:user, default_gravatar: false)
      expect(user.display_image).to eq(user.pic_url)
    end

    it "uses another source if using default gravatar" do
      user = FactoryGirl.create(:user, default_gravatar: true)
      expect(User::IMAGE_SOURCES).to include(user.display_image)
    end

    it "uses another source if pic_url is nil" do
      user = FactoryGirl.create(:user, pic_url: nil)
      expect(User::IMAGE_SOURCES).to include(user.display_image)
    end

    it "uses another source if pic_url is empty" do
      user = FactoryGirl.create(:user, pic_url: "")
      expect(User::IMAGE_SOURCES).to include(user.display_image)
    end
  end
end
