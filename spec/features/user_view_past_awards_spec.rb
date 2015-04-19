require 'spec_helper'

feature 'user views past awards', %q{

  As a Launcher
  I want to see last week's awards
  So that I can see the history of LaunchVotes.

} do

  # Acceptance Criteria:
  # [x] An unauthenticated user can view past awards
  # [x] A link to past awards should exist on the root page
  # [x] A nomination without any votes is not an award

  let!(:nomination) { FactoryGirl.create(:nomination, created_at: 1.week.ago) }

  scenario 'view past awards' do
    award = create_award
    visit '/'
    click_on "View Past Awards"
    expect(page).to have_content(award.content)
    expect(page).to_not have_content(nomination.content)
  end

end

def create_award
  award = FactoryGirl.create(:nomination)
  FactoryGirl.create(:vote, nomination: award)
  award.created_at = 1.week.ago
  award.save
  award
end
