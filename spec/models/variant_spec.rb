require 'rails_helper'

RSpec.describe Variant, type: :model do
  it "has working factory" do
    FactoryBot.create :variant
  end

  it 'links generative' do
    first = FactoryBot.create :variant, source_identifier: '1'
    second = FactoryBot.build(:variant, source_identifier: '2')
    first.assessment.variants << second
    expect(first.other_variants).to include second
  end

  it 'does not require source_identifier for generative' do
    assessment = FactoryBot.create :assessment
    assessment.variants << FactoryBot.create(:variant, source_identifier: '1')
    second = FactoryBot.build :variant
    assessment.variants << second
    expect(second).to be_valid
  end
end
