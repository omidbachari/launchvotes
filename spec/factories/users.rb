FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| 10000 + n }
    provider "github"
    sequence(:email) { |n| "launcher#{n}@gmail.com" }
    sequence(:name) { |n| "Launchy McLauncher #{n}" }
    sequence(:username) { |n| "rubyhacker#{n}"}
    pic_url "http://localhost:4567/images/lazer-cat.gif"
    github_token { SecureRandom.hex }
  end
end
