require "spec_helper"

feature "current team" do
  scenario "a new user should belong to the current team" do
    user = FactoryGirl.create(:user)
    login_as user
    expect(user.teams).to include(Team.current_team)
  end
end
