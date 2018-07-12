FactoryBot.define do
  factory :assessment do
    format

    identifier { SecureRandom.uuid }
    association :member, factory: :member

    visibility { :internal }

    after(:create) do |asm|
      if asm.questions.none?
        asm.questions << FactoryBot.create(:question, assessment: asm, format: asm.format)
      end

    end

  end
end
