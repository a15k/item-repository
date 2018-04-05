FactoryBot.define do
  factory :question do
    assessment
    format
    content { Faker::Hacker.say_something_smart }
    association :created_by, factory: :user

    transient do
      solutions_count 4
    end

    after(:create) do |q, evaluator|
      create_list(:solution, evaluator.solutions_count, question: q)
    end

  end
end
