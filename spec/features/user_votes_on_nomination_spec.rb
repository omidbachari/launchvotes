require 'spec_helper'

feature 'user votes on a nomination', %q{

  As a Launcher
  I want to vote on a nomination
  So that the silliest nominations rise to the top!

} do

  let(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user votes on a nomination' do
    nomination = FactoryGirl.create(:nomination)
    login_as user

    visit '/nominations'
    find('input.votes').click
    expect(page).to have_content("You have voted!")
  end

  scenario 'user cannot vote twice for the same nomination' do
    nomination = FactoryGirl.create(:nomination)
    login_as user

    visit '/nominations'
    find('input.votes').click
    find('input.votes').click
    expect(page).to have_content("You have already voted on this nomination!")
  end

  scenario 'user cannot vote on old nominations' do
    nomination = FactoryGirl.create(:nomination, created_at: 1.week.ago)
    login_as user

    visit '/nominations/1/weeks_ago'
    expect(page).to_not have_css('input.votes')
  end

  scenario 'nominator cannot vote on a nomination they have made' do
    nomination = FactoryGirl.create(:nomination, nominator: user)
    login_as user

    visit '/nominations'
    find('input.votes').click
    expect(page).to have_content('You made this nomination. Your vote does not count!')
  end

end
