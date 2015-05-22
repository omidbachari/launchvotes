require "spec_helper"

feature "default team" do
  scenario "a new user should belong to the default team" do
    user = FactoryGirl.create(:user)
    login_as user
    expect(user.teams).to include(Team.default_team)
  end
end
