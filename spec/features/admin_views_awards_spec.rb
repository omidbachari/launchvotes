require 'spec_helper'

feature 'admin views awards' do
  let(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let(:user) { FactoryGirl.create(:user) }
  let!(:nomination) { FactoryGirl.create(:nomination) }

  scenario 'only admins can see awards page' do
    login_as user
    visit '/awards'
    expect(page).to have_content('You are not authorized to view this resource!')
  end

  scenario 'nomination without votes is not seen' do
    login_as admin
    visit '/awards'
    expect(page).to_not have_content(nomination.content)
  end
end
