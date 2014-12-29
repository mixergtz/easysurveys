# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey do
    title "MyString"
    description "MyText"
    state 1
  end
end
