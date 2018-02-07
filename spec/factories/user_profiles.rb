FactoryBot.define do
  factory :user_profile, aliases: [:profile] do
    association :organization
    after(:build) do |profile, evaluator|
      profile.account ||= FactoryBot.create(:openstax_accounts_account)
    end
  end
end
