FactoryBot.define do
  factory :user do
    association :member
    after(:build) do |profile, evaluator|
      profile.account ||= FactoryBot.create(
        :openstax_accounts_account,
        username: Faker::Internet.user_name,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      )
    end
  end
end
