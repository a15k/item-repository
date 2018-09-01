require 'rails_helper'

RSpec.describe Variant, type: :model do
  it "has working factory" do
    FactoryBot.create :variant
  end

  it 'links generative' do
    first = FactoryBot.create :variant, member_variant_id: '1'
    second = FactoryBot.build(:variant, member_variant_id: '2')
    first.assessment.questions << second
    expect(first.variants).to include second
  end

  it 'requires variant id for generative' do
    assessment = FactoryBot.create :assessment
    assessment.questions << FactoryBot.create(:variant, member_variant_id: '1')
    second = FactoryBot.build :variant
    assessment.questions << second
    expect(second).not_to be_valid
    expect(second.errors.full_messages.first).to include 'Variant must be present'
  end
end
