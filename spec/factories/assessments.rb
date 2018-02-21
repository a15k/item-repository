FactoryBot.define do
  factory :assessment do
    format
    association :owner, factory: :assessment_owner
    association :created_by, factory: :user
  end
end
