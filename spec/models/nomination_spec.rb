require 'spec_helper'

RSpec.describe Nomination, model: true do
  it { should belong_to(:nominee) }
  it { should belong_to(:nominator) }
  it { should have_many(:votes) }

  it { should have_valid(:content).when('Best gif collection', 'Worst Indentation', 'git commit --all-the-things') }
  it { should_not have_valid(:content).when(nil, '') }

  it { should validate_presence_of(:nominee) }
  it { should validate_presence_of(:nominator) }

  describe '.this_week' do
    it 'should scope records to a current week' do
      old_nomination = FactoryGirl.create(:nomination, created_at: 1.week.ago)
      new_nomination = FactoryGirl.create(:nomination)

      expect(Nomination.this_week).to include(new_nomination)
      expect(Nomination.this_week).to_not include(old_nomination)
    end
  end
end
