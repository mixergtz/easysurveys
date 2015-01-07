# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey do
    title "New Survey"
    description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer maximus sem eget pellentesque dapibus. Cras ex orci, pharetra ac pellentesque at, vestibulum sit amet ante."
    state 0
    association :user

    factory :published_survey do
      state 1
    end

  end

end
