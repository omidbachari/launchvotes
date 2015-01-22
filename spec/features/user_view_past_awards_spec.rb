require 'spec_helper'

feature 'user views past awards', %q{

  As a Launcher
  I want to see last week's awards
  So that I can see the history of LaunchVotes.

  Acceptance Criteria:
  [x] An unauthenticated user can view past awards
  [x] A link to past awards should exist on the root page

} do

  scenario 'view past awards' do
    nomination = FactoryGirl.create(:nomination, created_at: 1.week.ago)
    visit '/'
    click_on "View Past Awards"
    expect(page).to have_content(nomination.content)
  end

end
