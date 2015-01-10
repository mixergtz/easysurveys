# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    description { Faker::Lorem.sentence }
    association :survey
  end
end
