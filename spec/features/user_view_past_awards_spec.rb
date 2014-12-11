require 'spec_helper'

feature 'user views past awards', %q{

  As a Launcher
  I want to see last week's awards
  So that I can see the history of LaunchVotes.

} do

  let(:user) { FactoryGirl.create(:user) }

  scenario 'view past awards' do
    nomination = FactoryGirl.create(:nomination, created_at: 1.week.ago)
    login_as user
    click_on 'Time Travel'
    expect(page).to have_content(nomination.content)
  end

end
