FactoryBot.define do
  factory :translator do
    name { Faker::Company.name }
    association :input, factory: :format
    association :output, factory: :format
    interpreter { Faker::ProgrammingLanguage.name }
  end
end
