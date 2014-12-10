FactoryGirl.define do
  factory :nomination do
    sequence(:content) do
      [
        "Most glorious beard",
        "Best hairdo",
        "Most help requests",
        "Fastest typer",
        "Best spectacles",
        "Best accent",
        "Most likely to `git push origin master -f`",
        "Breakable toy is already funded on Kickstarter"
      ].sample
    end

    association :nominee, factory: :user
    association :nominator, factory: :user
  end
end
