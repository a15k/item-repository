FactoryBot.define do
  factory :question do
    assessment
    format
    content { Faker::Hacker.say_something_smart }
    association :created_by, factory: :user
  end
end
