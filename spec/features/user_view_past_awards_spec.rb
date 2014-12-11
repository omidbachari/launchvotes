require 'spec_helper'

feature 'user views past awards', %q{

  As a Launcher
  I want to see last week's awards
  So that I can see the history of LaunchVotes.

  Acceptance Criteria:
  [ ] An unauthenticated user can view past awards
  [ ] A link to past awards should exist on the root page

} do

  let(:user) { FactoryGirl.create(:user) }

  scenario 'view past awards' do
    nomination = FactoryGirl.create(:nomination, created_at: 1.week.ago)
    login_as user
    click_on 'Time Travel'
    expect(page).to have_content(nomination.content)
  end

end
