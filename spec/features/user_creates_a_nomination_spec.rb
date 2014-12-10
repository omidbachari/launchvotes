require 'spec_helper'

feature 'user creates a nomination', %q{

  As a Launcher
  I want to nominate fellow Launchers for awards
  So that everyone can celebrate their awesomeness.

} do

  let(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user nominates another user' do
    nomination = FactoryGirl.build(:nomination)
    login_as user

    select nomination.nominee.name, from: 'Nominee'
    fill_in 'Content', with: nomination.content
    click_on 'Submit'

    expect(page).to have_content('Your nomination has been made!')
  end

  scenario 'user cannot nominate self' do
    login_as user

    select user.name, from: 'Nominee'
    fill_in 'Content', with: 'Best Hairdo'
    click_on 'Submit'

    expect(page).to have_content('Egotistical nomination detected! Submission rejected.')
  end

  scenario 'duplicate nominations for the same nominee are rejected' do
    nomination = FactoryGirl.create(:nomination)

    login_as user

    select nomination.nominee.name, from: 'Nominee'
    fill_in 'Content', with: nomination.content
    click_on 'Submit'

    expect(page).to have_content('Duplicate nomination detected! Submission rejected.')
  end

  scenario 'duplicate nominations by the same user are rejected' do
    nomination_one = FactoryGirl.create(:nomination, nominator: user)
    nomination_two = FactoryGirl.build(:nomination)

    login_as user

    select nomination_two.nominee.name, from: 'Nominee'
    fill_in 'Content', with: nomination_one.content
    click_on 'Submit'

    expect(page).to have_content('You have already nominated someone for this award!')
  end

  scenario 'injecting tags into the page is not allowed' do
    nomination = FactoryGirl.build(:nomination)
    login_as user

    malicious_code = "<script>window.open('http://heyyeyaaeyaaaeyaeyaa.com/')</script>"

    select nomination.nominee.name, from: 'Nominee'
    fill_in 'Content', with: malicious_code
    click_on 'Submit'

    expect(page).to_not have_content(malicious_code)
  end
end
