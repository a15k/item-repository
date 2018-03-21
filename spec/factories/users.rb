FactoryBot.define do
  factory :user do
    association :member
    after(:build) do |profile, evaluator|
      profile.account ||= FactoryBot.create(:openstax_accounts_account)
    end
  end
end
