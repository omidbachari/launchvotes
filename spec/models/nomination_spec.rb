require 'spec_helper'

RSpec.describe Nomination, model: true do
  it { should belong_to(:nominee) }
  it { should belong_to(:nominator) }
  it { should have_many(:votes) }
end
