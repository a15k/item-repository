require 'rails_helper'

RSpec.describe Format, type: :model do
  it "has working factory" do
    FactoryBot.create :format
  end

  it 'must be unused to be destroyed' do
    variant = FactoryBot.create(:variant)
    format = variant.format
    solution = FactoryBot.create(:solution, format: format)

    format.destroy
    expect(format).not_to be_destroyed

    assessment = variant.assessment
    assessment.enable_destroy = true
    assessment.destroy

    format.destroy
    expect(format).not_to be_destroyed

    solution.destroy

    format.destroy
    expect(format).to be_destroyed
  end
end
