FactoryBot.define do
  factory :member do
    name { Faker::Educator.university }
  end
end
