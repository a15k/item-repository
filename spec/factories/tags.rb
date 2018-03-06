FactoryBot.define do
  factory :tag do
    organization
    name { Faker::Job.field }
  end
end
