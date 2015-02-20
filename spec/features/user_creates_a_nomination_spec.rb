require 'spec_helper'

feature 'user creates a nomination', %q{

  As a Launcher
  I want to nominate fellow Launchers for awards
  So that everyone can celebrate their awesomeness.

} do

  let!(:team) { FactoryGirl.create(:team) }
  let!(:teammate_1) { FactoryGirl.create(:team_membership, team: team).user }
  let!(:teammate_2) { FactoryGirl.create(:team_membership, team: team).user }
  let!(:other_guy) { FactoryGirl.create(:team_membership).user }

  scenario 'users can only nominate people on the same team' do
    login_as teammate_1

    within("#nomination_nominee_id") do
      expect(page).to have_content(teammate_2.name)
    end
  end

  scenario 'users can only nominate people on the same team' do
    login_as teammate_1

    within("#nomination_nominee_id") do
      expect(page).to_not have_content(other_guy.name)
    end
  end

  scenario 'authenticated user nominates another user' do
    login_as teammate_1

    select teammate_2.name, from: 'Nominee'
    fill_in 'Content', with: "Most Glorious Beard"
    click_on 'Submit'

    expect(page).to have_content('Your nomination has been made!')
  end

  scenario 'user cannot nominate self' do
    login_as other_guy

    select other_guy.name, from: 'Nominee'
    fill_in 'Content', with: 'Best Hairdo'
    click_on 'Submit'

    expect(page).to have_content('Egotistical nomination detected! Submission rejected.')
  end

  scenario 'injecting tags into the page is not allowed' do
    login_as teammate_1

    malicious_code = "<script>window.open('http://heyyeyaaeyaaaeyaeyaa.com/')</script>"

    select teammate_2.name, from: 'Nominee'
    fill_in 'Content', with: malicious_code
    click_on 'Submit'

    expect(page).to_not have_content(malicious_code)
  end
end
