FactoryBot.define do
  factory :variant do
    assessment {
      FactoryBot.build(:assessment, variants: [@instance])
    }

    format
    content { Faker::Hacker.say_something_smart }

    transient do
      solutions_count 1
    end

    after(:create) do |q, evaluator|
      create_list(:solution, evaluator.solutions_count, variant: q, format: q.format)
    end
  end
end
