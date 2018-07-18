FactoryBot.define do
  factory :assessment do

    identifier { SecureRandom.uuid }
    association :member, factory: :member

    visibility { :internal }

    transient do
      format { FactoryBot.create(:format) }
    end

    after(:create) do |asm, evaluator|
      if asm.questions.none?
        asm.questions << FactoryBot.create(:question,
                                           assessment: asm,
                                           format: evaluator.format)
      end
    end

  end
end
