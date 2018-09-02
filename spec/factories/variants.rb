FactoryBot.define do
  factory :variant do
    assessment {
      FactoryBot.build(:assessment, variants: [@instance])
    }

    format
    content { Faker::Hacker.say_something_smart }
    preview_html { Faker::Lorem.paragraphs.join("<br/>") }

    transient do
      solutions_count 1
    end

    # Commenting out until figure out plan for community solutions
    # after(:create) do |q, evaluator|
    #   create_list(:solution, evaluator.solutions_count, variant: q, format: q.format)
    # end
  end
end
