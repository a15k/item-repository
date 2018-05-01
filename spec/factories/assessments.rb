FactoryBot.define do
  factory :assessment do
    format

    identifier { SecureRandom.uuid }
    association :created_by, factory: :user
    visibility { :internal }

    after(:create) do |asm|
      create_list(:question, 1, assessment: asm, format: asm.format)
    end

  end
end
