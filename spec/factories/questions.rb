FactoryBot.define do
  factory :question do
    assessment {
      FactoryBot.build(:assessment, questions: [@instance])
    }

    format
    content { Faker::Hacker.say_something_smart }

    transient do
      solutions_count 1
    end

    after(:create) do |q, evaluator|
      create_list(:solution, evaluator.solutions_count, question: q, format: q.format)
    end
  end
end
