FactoryBot.define do
  factory :assessment do
    format

    association :created_by, factory: :user
    visibility { :internal }



    after(:create) do |asm|
      create_list(:question, 1, assessment: asm)
      create_list(:solution, 1, assessment: asm)
    end

  end
end
