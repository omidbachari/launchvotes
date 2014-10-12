FactoryGirl.define do
  factory :github_team do
    sequence(:tid) { |n| 10000 + n }
    sequence(:name) { |n| "GitHub Team #{n}" }
  end
end
