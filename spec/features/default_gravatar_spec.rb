require "spec_helper"

feature "default gravatar", focus: true do
  let(:user) { FactoryGirl.create(:user) }

  context "nominee has default gravatar" do
    let(:lazy_user) do
      FactoryGirl.create(:user,
        pic_url: "https://avatars2.githubusercontent.com/u/11095274?v=3&s=400"
      )
    end

    let!(:nomination) { FactoryGirl.create(:nomination, nominee: lazy_user) }

    scenario "default gravatars are replaced" do
      login_as user
      visit "/nominations"
      expect(page).to_not have_css("img[src='#{nomination.nominee.pic_url}']")
    end
  end

  context "nominee does not have default gravatar" do
    let!(:nomination) { FactoryGirl.create(:nomination) }

    scenario "default gravatars are replaced" do
      login_as user
      visit "/nominations"
      expect(page).to have_css("img[src='#{nomination.nominee.pic_url}']")
    end
  end
end
