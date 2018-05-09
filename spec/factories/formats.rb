FactoryBot.define do
  factory :format do
    identifier { Faker::Hipster.word.downcase }
    name { Faker::Hipster.word }
    specification { Faker::Hipster.sentence }
    association :created_by, factory: :user
  end
end
