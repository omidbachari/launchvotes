require 'spec_helper'

feature 'user views a list of nominations', %q{

  As a Launcher
  I want to see what my fellow Launchers have been nominated for
  So that I might have a laugh.

} do

  let(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user views nominations' do
    nominations = []
    10.times { nominations << FactoryGirl.create(:nomination) }

    login_as user
    visit '/nominations'

    nominations.each do |nomination|
      expect(page).to have_content(nomination.nominee.name)
      expect(page).to have_content(nomination.content)
    end
  end

end
