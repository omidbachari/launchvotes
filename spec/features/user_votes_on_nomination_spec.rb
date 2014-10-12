require 'spec_helper'

feature 'user votes on a nomination', %q{

  As a Launcher
  I want to vote on a nomination
  So that the silliest nominations rise to the top!

} do

  let(:user) { FactoryGirl.create(:user) }
  let!(:nomination) { FactoryGirl.create(:nomination) }

  scenario 'authenticated user votes on a nomination' do
    login_as user

    visit '/nominations'
    click_on 'Vote'
    expect(page).to have_content("You have voted!")
  end

  scenario 'user cannot vote twice for the same nomination' do
    login_as user

    visit '/nominations'
    click_on 'Vote'
    click_on 'Vote'
    expect(page).to have_content("You have already voted on this nomination!")
  end

end
