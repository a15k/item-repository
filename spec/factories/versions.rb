FactoryBot.define do
  factory :version do
    assessment
    format
    association :created_by, factory: :user
  end
end
