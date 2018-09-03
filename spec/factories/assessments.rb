FactoryBot.define do
  factory :assessment do

    source_identifier { SecureRandom.hex(8) }
    association :member, factory: :member

    transient do
      format { FactoryBot.create(:format) }
    end

    after(:create) do |asm, evaluator|
      if asm.variants.none?
        asm.variants << FactoryBot.create(:variant,
                                           assessment: asm,
                                           format: evaluator.format)
      end
    end

  end
end
