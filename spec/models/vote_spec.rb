require 'spec_helper'

RSpec.describe Vote, model: true do
  it { should belong_to(:nomination) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:nomination) }
  it { should validate_presence_of(:user) }

  it 'should validate uniqueness of nomination scoped to user' do
    vote = FactoryGirl.create(:vote)
    second_vote = FactoryGirl.build(:vote, nomination: vote.nomination, user: vote.user)

    expect { second_vote.save!}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
