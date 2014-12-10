FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| "#{10000 + n}" }
    provider 'github'
    sequence(:email) { |n| "launcher#{n}@gmail.com" }
    sequence(:name) { |n| "Launchy McLauncher #{n}" }
    pic_url "http://i.imgur.com/vnEJUtm.gif"
  end
end
