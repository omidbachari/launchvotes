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

end
