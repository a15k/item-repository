FactoryBot.define do
  factory :format do
    identifier { Faker::Hipster.word.downcase }
    name { Faker::Hipster.word }
    description { Faker::Hipster.sentence }
  end
end
