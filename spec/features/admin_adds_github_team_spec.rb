require 'spec_helper'

feature 'admin adds a github team', %q{

  As a LaunchVotes admin
  I want to add Github team members to the site
  So that everyone in my team can nominate and vote

} do

  let(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:github_team) { FactoryGirl.create(:github_team) }

  scenario 'admin adds a github team' do
    login_as admin

    visit '/teams'
    select github_team.name, from: 'GitHub Team'
    click_on 'Import Team'

    expect(page).to have_content("Members of #{github_team.name} added successfully!")
  end

end
