FactoryBot.define do
  factory :assessment do

    identifier { SecureRandom.uuid }
    association :member, factory: :member
    preview_html { Faker::Lorem.paragraphs }
    visibility { :internal }

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
