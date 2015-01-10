# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey_response do
    association :survey
    association :question
    association :answer
  end
end
