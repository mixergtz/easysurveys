# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    state 0
    association :user

    factory :published_survey do
      state 1
    end

  end
end
