FactoryBot.define do
  factory :assessment do
    format
    association :created_by, factory: :user
  end
end
