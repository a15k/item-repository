FactoryBot.define do
  factory :format do
    name { Faker::Hipster.word }
    description { Faker::Hipster.sentence }
  end
end
