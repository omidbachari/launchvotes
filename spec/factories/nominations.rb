FactoryGirl.define do
  factory :nomination do
    sequence(:content) { Nomination.examples.sample }
    association :nominee, factory: :user
    association :nominator, factory: :user
  end
end
