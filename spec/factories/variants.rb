FactoryBot.define do
  factory :variant do
    assessment {
      FactoryBot.build(:assessment, variants: [@instance])
    }

    format
    content { Faker::Hacker.say_something_smart }
  end
end
