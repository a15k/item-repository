FactoryBot.define do
  factory :asset do
    assessment
    type { %i[link image assessment].sample }
    content_type { ['text/html', 'application/json', 'image/png'].sample }
  end
end
