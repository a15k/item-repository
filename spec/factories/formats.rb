FactoryBot.define do
  factory :format do
    name { Faker::Educator.university }
    specification { Faker::Hipster.sentence }
    association :created_by, factory: :member
  end
end
