FactoryBot.define do
  factory :assessment do

    member_version_stable_id { SecureRandom.hex(8) }
    a15k_version_stable_id { SecureRandom.uuid }
    a15k_version { 1 }

    association :member, factory: :member
    preview_html { Faker::Lorem.paragraphs }

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
