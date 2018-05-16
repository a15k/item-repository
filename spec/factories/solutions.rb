FactoryBot.define do
  factory :solution do
    question
    format
    content { Faker::Hacker.say_something_smart }
    association :created_by, factory: :member
  end
end
