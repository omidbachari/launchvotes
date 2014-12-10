require 'spec_helper'

RSpec.describe GithubTeam, model: true do
  it { should have_many(:users) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:tid) }
end
