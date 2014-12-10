require 'spec_helper'

RSpec.describe Nomination, model: true do
  it { should belong_to(:nominee) }
  it { should belong_to(:nominator) }
  it { should have_many(:votes) }

  it { should have_valid(:content).when('Best gif collection', 'Worst Indentation', 'git commit --all-the-things') }
  it { should_not have_valid(:content).when(nil, '') }

  it { should validate_presence_of(:nominee) }
  it { should validate_presence_of(:nominator) }
end
