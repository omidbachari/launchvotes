require 'spec_helper'

RSpec.describe Nomination, model: true do
  it { should belong_to(:nominee) }
  it { should belong_to(:nominator) }
  it { should have_many(:votes) }

  it { should have_valid(:content).when('Best gif collection', 'Worst Indentation', 'git commit --all-the-things') }
  it { should_not have_valid(:content).when(nil, '') }

  it { should validate_presence_of(:nominee) }
  it { should validate_presence_of(:nominator) }

  it 'should validate uniqueness of content scoped to nominee' do
    nomination = FactoryGirl.create(:nomination)

    expect {
      FactoryGirl.create(:nomination,
        nominee: nomination.nominee,
        content: nomination.content)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should validate uniqueness of content scoped to nominator' do
    nomination = FactoryGirl.create(:nomination)

    expect {
      FactoryGirl.create(:nomination,
        nominator: nomination.nominator,
        content: nomination.content)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should validate that nominee cannot be nominator' do
    user = FactoryGirl.create(:user)

    expect {
      FactoryGirl.create(:nomination,
        nominee: user,
        nominator: user)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe "#votable?" do
    it 'should return true for nominations made this week' do
      nomination = FactoryGirl.create(:nomination)
      expect(nomination.votable?).to be true
    end

    it 'should return false for nominations made last week' do
      nomination = FactoryGirl.create(:nomination, created_at: 1.week.ago)
      expect(nomination.votable?).to be false
    end
  end

  describe '.this_week' do
    it 'should scope records to a current week' do
      old_nomination = FactoryGirl.create(:nomination, created_at: 1.week.ago)
      new_nomination = FactoryGirl.create(:nomination)

      expect(Nomination.this_week).to include(new_nomination)
      expect(Nomination.this_week).to_not include(old_nomination)
    end
  end

  describe '#votes_count' do
    let!(:nomination) { FactoryGirl.create(:nomination) }

    it "should be zero, initially" do
      expect(nomination.votes_count).to eq(0)
    end

    it "should equal the number of votes" do
      FactoryGirl.create_list(:vote, 3, nomination: nomination)
      nomination.reload
      expect(nomination.votes_count).to eq(3)
    end
  end
end
