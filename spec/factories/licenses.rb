FactoryBot.define do
  factory :license do
    abbreviation { ['CC BY', 'CC BY-SA', 'CC BY-ND', 'CC BY-NC'].sample }
    url { Faker::Internet.url }
    terms { Faker::Lorem.paragraphs }
  end
end
