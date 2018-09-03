FactoryBot.define do


  factory :asset do

    trait :for_variant do
      association :owner, factory: :variant
    end

    trait :for_solution do
      association :owner, factory: :solution
    end

    association :created_by, factory: :member
    content_type { ['text/html', 'application/json', 'image/png'].sample }
  end
end
