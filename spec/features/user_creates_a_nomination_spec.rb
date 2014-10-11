require 'spec_helper'

feature 'user creates a nomination', %q{

  As a Launcher
  I want to point out other Launcher's idiosyncrasies
  So that everyone can celebrate their wonderful uniqueness.

} do

  let(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user nominates another user' do
    nomination = FactoryGirl.build(:nomination)
    login_as user

    fill_in 'Nomination', with: nomination.content
    click_button 'Submit'
    expect(page).to have_content('Your nomination has been recorded!')
  end

end
