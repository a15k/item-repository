require 'rails_helper'

RSpec.describe Assessment, type: :model do
  let(:member) { FactoryBot.create :member }
  let(:assessment) { FactoryBot.create :assessment, member: member, identifier: '1234' }

  it 'tracks versions' do
    other = FactoryBot.create :assessment, member: member, identifier: '1234'
    versions = assessment.other_versions.reload
    expect(versions).not_to include assessment
    expect(versions).to include other
  end

  it 'disallows other members from making new versions' do
    other_member = FactoryBot.create :member
    other = Assessment.new(
      identifier: '1234',
      member: other_member,
      format: assessment.format
    )
    expect(other.save).to be false
    expect(other.errors[:member]).to include 'must be the same as other versions'
  end

end
