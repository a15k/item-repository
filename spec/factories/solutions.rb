FactoryBot.define do
  factory :solution do
    assessment
    format
    content { Faker::Hacker.say_something_smart }
    association :created_by, factory: :user
  end
end
