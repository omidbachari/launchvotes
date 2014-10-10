FactoryGirl.define do
  factory :user do
    skip_create

    sequence(:uid) { |n| "#{10000 + n}" }
    sequence(:email) { |n| "launcher#{n}@gmail.com" }
    sequence(:name) { |n| "Launchy McLauncher #{n}" }
    avatar_url "http://i.imgur.com/vnEJUtm.gif"
  end
end
